---
title: Containerised Mastodon server on NixOS
date: 2023-01-15
tags: [nix, fediverse]
---

I've been on the fediverse on and off since [friendi.ca](https://friendi.ca/) started to be a thing.
I remember hosting an instance at ponk.pink that suddenly got popular and the server melted away while I was apologising to the users.
I can see someone bought the domain to host some psychedelic My Little Pony stuff, I'm all for that.

I moved to [todon.nl](https://todon.nl/) when it got started and was quite happy there - check it out if you're looking for an instance !
The itch was there though, what if I host my own small cozy place on the fediverse myself.
I knew I didn't have as much time to do server admin, so I decided to start small, with a single user instance an use the power of NixOS to help with maintenance.

Here is my full config - hosting Mastodon under the apex domain of [peninsula.industries](https://peninsula.industries/), Mastodon is running inside a systemd container and the config is using nix-sops to store the secrets.
Few things that were unexpected/of note 
  - I needed to create the folder structure with correct permissions so that Mastodon starts normally. This in turn required setting up users and groups both on host and inside the container so that their uids and gids match. 
  - I'm decrypting secrets on the host and making them available read-only to the container. Not sure if this is better or worse than having sops inside of the container, but I was having some trouble using sops module from there, so left it as it is for now - something to look into in the future
  - I needed to change the postgres port that is running inside of the Mastodon container because I had another postgres on this host already.   
  - If you're gonna be playing with this a lot, you might need to remove the container and its data and start from scratch - you can do so by doing:
    - remove the container definition and `nixos-rebuild switch`
    - `rm -fr /var/lib/nixos-containers/mastodon/`
  - to use Mastodon CLI you need to be running it as a correct user and within the Nix-changed env:
    ```bash
    nixos-container root-login mastodon
    sudo -u mastodon bash
    cd
    source mastodon-env
    RAILS_ENV=production tootctl
    ```
  - The below can use some refactoring, there is some weird repetition in some places still
  - You can find the newest version of this and see how it's being used in context on my [code hosting site](https://git.cyplo.dev/cyplo/dotfiles/src/branch/main/nixos/boxes/vpsfree1/mastodon.nix).
  - Share your thoughts on the [fedi thread for this article](https://peninsula.industries/@cyplo/109692744740475900) !
```nix
{
  config,
  pkgs,
  inputs,
  lib,
  ...
}: let
  domain = "peninsula.industries";
  streamingPort = 55000;
  webPort = 55001;
  postgresPort = 5433;
  path = "/var/lib/mastodon/";
  mailgunSmtpSecretName = "mastodon-mailgun-smtp-password";
  mailgunSmtpPasswordPath = "/run/secrets/${mailgunSmtpSecretName}";
  mastodonDbSecretName = "mastodon-db";
  mastodonDbSecretPath = "/run/secrets/${mastodonDbSecretName}";
  uid = 2049;
  gid = 3049;
  systemUserName = "mastodon";
  systemGroupName = "mastodon";
  users = {
    users."${systemUserName}" = {
      inherit uid;
      isSystemUser = true;
      isNormalUser = false;
      group = systemGroupName;
    };
    groups."${systemGroupName}" = {
      inherit gid;
      members = ["${systemUserName}" "nginx"];
    };
  };
  secretSettings = {
    owner = systemUserName;
    group = systemGroupName;
  };
  publicPath = "${path}/public-system/";
  package =
    inputs.nixpkgs-nixos-unstable.legacyPackages."${pkgs.system}".mastodon;
in {
  imports = [../nginx.nix];

  services.nginx = {
    virtualHosts = {
      "${domain}" = {
        forceSSL = true;
        enableACME = true;
        root = "${package}/public/";

        locations."/" = {tryFiles = "$uri @proxy";};
        locations."/system/".alias = "${publicPath}";

        locations."@proxy" = {
          proxyPass = "http://127.0.0.1:" + toString webPort;
          proxyWebsockets = true;
        };
        locations."/api/v1/streaming/" = {
          proxyPass = "http://127.0.0.1:" + toString streamingPort;
          proxyWebsockets = true;
        };
      };
    };
  };

  sops.secrets."${mailgunSmtpSecretName}" =
    {
      sopsFile = ./mailgun.sops.yaml;
      path = mailgunSmtpPasswordPath;
    }
    // secretSettings;
  sops.secrets."${mastodonDbSecretName}" =
    {
      sopsFile = ./mastodon-db.sops.yaml;
      path = mastodonDbSecretPath;
    }
    // secretSettings;

  inherit users;

  systemd.services.mastodon-make-path = {
    script = ''
      mkdir -p ${path}
      chown -R ${systemUserName}:${systemGroupName} ${path}
      mkdir -p ${publicPath}
      chmod -R o-rwx ${publicPath}
      chmod -R g-rwx ${publicPath}
      chmod -R g+X ${publicPath}
      chmod -R g+r ${publicPath}
      chmod -R u+rwX ${publicPath}
    '';
    serviceConfig = {
      Type = "oneshot";
      ProtectSystem = "strict";
      ReadWritePaths = path;
    };
    before = ["container@mastodon.service"];
  };

  containers.mastodon = {
    autoStart = true;
    forwardPorts = [
      {
        containerPort = streamingPort;
        hostPort = streamingPort;
      }
      {
        containerPort = webPort;
        hostPort = webPort;
      }
    ];
    bindMounts = {
      "${path}" = {
        hostPath = "${path}";
        isReadOnly = false;
      };
      "${mailgunSmtpPasswordPath}" = {
        hostPath = "${mailgunSmtpPasswordPath}";
        isReadOnly = true;
      };
      "${mastodonDbSecretPath}" = {
        hostPath = "${mastodonDbSecretPath}";
        isReadOnly = true;
      };
    };
    config = {
      config,
      pkgs,
      lib,
      ...
    }: {
      system.stateVersion = "22.05";
      services.postgresql.port = postgresPort;
      users =
        users
        // {
          mutableUsers = false;
          allowNoPasswordLogin = true;
        };
      services.mastodon = {
        enable = true;
        inherit package;
        localDomain = "${domain}";
        user = systemUserName;
        group = systemGroupName;
        smtp = {
          host = "smtp.eu.mailgun.org";
          port = 465;
          authenticate = true;
          user = "postmaster@${domain}";
          fromAddress = "Peninsula Industries Mastodon <mastodon@${domain}>";
          createLocally = false;
          passwordFile = "${mailgunSmtpPasswordPath}";
        };
        extraConfig = {
          SMTP_TLS = "true";
          SMTP_ENABLE_STARTTLS_AUTO = "true";
          SINGLE_USER_MODE = "true";
          RAILS_SERVE_STATIC_FILES = "true";
        };
        inherit streamingPort;
        inherit webPort;
        configureNginx = false;
        enableUnixSocket = false;
        database = {
          port = postgresPort;
          passwordFile = mastodonDbSecretPath;
        };
      };
    };
  };
}
```

