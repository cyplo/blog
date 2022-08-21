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
      let pkgs = nixpkgs.legacyPackages."${system}";
      in rec {
        # `nix develop`
        devShell = pkgs.mkShell {
          nativeBuildInputs = with pkgs;
            with pkgs.python38Packages; [
              cacert
              git
              hugo
              hut
            ];
        };
      });
}
