{
  description = "Adventurous computing, a blog by Cyryl Płotnicki";
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
      in {
        devShell = pkgs.mkShell {
          buildInputs = with pkgs;
            with pkgs.python38Packages; [
              cacert
              git
              hugo
              hut
              ruby
              bundler
            ];
        };
      });
}
