---
title: How to use a non-default ssh port for a Nix distributed build host
date: 2022-11-01
tags: [nix]
---

I wanted to host my ssh server on a different port than the default `22`, this allows me to skip on some spam in the logs, as the default port gets scanned quite often.
By changing that on the server I broke distributing my nix builds, as they were using the default port as well.
It took me a while to figure out how to configure the port the builder would use so I thought I would share here.

Here's an example of a *client-side* configuration -  using a build server `buildHostName` with a user named `nix-builder`, connecting via ssh to port `1234`.
```nix
programs.ssh.extraConfig = ''
    Host buildHostName
	HostName buildHostName
	Port 1234
	StrictHostKeyChecking=accept-new
'';

nix.buildMachines = [{
    hostName = "buildHostName";
    sshUser = "nix-builder";
    sshKey = "/path/to/key";
    systems = [ "x86_64-linux" ];
    maxJobs = 2;
    speedFactor = 2;
    supportedFeatures = [ "kvm" ];
    mandatoryFeatures = [ ];
}];
```
