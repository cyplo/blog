---
title: Quick reproducible zig dev env using nix flakes
date: 2022-01-01
tags: [zig, nix]
---

Want this great feeling of entering a directory and having all your dev setup done but can never remember how to set up nix flakes ?

What you'll need is, in addition to a working [direnv](https://direnv.net/) with `nix` and `nix flake` enabled, is:

`.envrc`:
```text
use flake
```

`.gitignore`:
```text
.direnv/
```

`flake.nix` (this `nixpkgs` hash points to the first revision with zig 0.9 present):
```nix
{
  inputs = {
    nixpkgs = {
      type = "github";
      owner = "nixos";
      repo = "nixpkgs";
      ref = "e1eeb53e64159fbb2610ba7810ed511e4d5c10ca";
    };
    flake-compat = {
      url = "github:edolstra/flake-compat";
      flake = false;
    };
  };

  outputs = { self, nixpkgs, flake-compat }:
    let pkgs = nixpkgs.legacyPackages.x86_64-linux;
    in
    {
      devShell.x86_64-linux =
        pkgs.mkShell {
          buildInputs = with pkgs;[
            nixpkgs-fmt
            zig
            zls
          ];
        };
    };
}
```

and some `shell.nix` for this extra bit of `nix-shell` compatibility, if you'd want it:
```nix
(import
  (
    let
      lock = builtins.fromJSON (builtins.readFile ./flake.lock);
    in
    fetchTarball {
      url = "https://github.com/edolstra/flake-compat/archive/${lock.nodes.flake-compat.locked.rev}.tar.gz";
      sha256 = lock.nodes.flake-compat.locked.narHash;
    }
  )
  {
    src = ./.;
  }).shellNix
```

Don't forget to:
* `git add` all of the above, otherwise nix flake operations might not work
* `direnv allow` this directory
* have fun !