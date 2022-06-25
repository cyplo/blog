{
  description = "legdur: verify integrity of large directories over time";
  inputs = {
    utils.url = "github:numtide/flake-utils";
    flake-compat = {
      url = "github:edolstra/flake-compat";
      flake = false;
    };
  };

  outputs = { self, nixpkgs, utils, flake-compat }:
    utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages."${system}";
        netlify-deployer = pkgs.python38Packages.buildPythonPackage rec {
          pname = "netlify_deployer";
          version = "0.5.2";

          src = pkgs.python38Packages.fetchPypi {
            inherit pname version;
            sha256 =
              "aae0092b36e7408281ad73269b446c701edaacecc8ba1a07cc85671e3ddfae6e";
          };

          propagatedBuildInputs = with pkgs;
            with pkgs.python38Packages; [
              requests
              git
              pbr
              wheel
              setuptools
            ];

          doCheck = false;
        };

        customPython =
          pkgs.python38.buildEnv.override { extraLibs = [ netlify-deployer ]; };
      in rec {
        # `nix develop`
        devShell = pkgs.mkShell {
          nativeBuildInputs = with pkgs;
            with pkgs.python38Packages; [
              git
              hugo
              cacert
              requests
              pip
              virtualenv
              customPython
            ];
        };
      });
}
