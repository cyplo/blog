let
  pkgs = import <nixpkgs> {};
in
pkgs.mkShell {
  buildInputs = with pkgs; with pkgs.python38Packages; [
      git
      hugo
      cacert
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
