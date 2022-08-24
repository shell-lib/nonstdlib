{
  description = "NonStandard Library";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };
  outputs = { self, nixpkgs, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
        package-name = "nonstdlib";
        run-dependencies = with pkgs; [];
      in rec {
        devShell = pkgs.mkShell {
          buildInputs = [
            pkgs.shellcheck
            pkgs.shfmt
          ];
        };

        defaultPackage = with import nixpkgs {inherit system; };
        stdenv.mkDerivation {
          name = package-name;
          src = self;
          installPhase = ''
            mkdir -p $out/bin;
            install --target-directory $out/bin $name;
            '';
        };
      });
}