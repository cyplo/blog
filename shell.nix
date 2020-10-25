let
  pkgs = import <nixpkgs> {};
in
pkgs.mkShell {
  buildInputs = with pkgs.python38Packages; [
      requests
      pip
      virtualenv
  ];

  shellHook = ''
    virtualenv simpleEnv
    source simpleEnv/bin/activate
    python3 -m pip install netlify-deployer
    '';
}
