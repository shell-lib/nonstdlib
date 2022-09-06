{
  description = "(Non)Standard Shell Library";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    bats.url = "github:shell-lib/bats-full-flake";
  };
  outputs = { self, nixpkgs, flake-utils, bats, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
        package-name = "nonstdlib.sh";
        run-dependencies = with pkgs; [];
        dev-tools = [ 
          pkgs.shellcheck
          pkgs.shfmt
          bats.packages.${system}.default
        ];
      in rec {
        devShells.default = pkgs.mkShell {
          buildInputs = dev-tools;
        };

        lib = pkgs.stdenv.mkDerivation {
          name = package-name;
          src = self;
          buildInputs = run-dependencies;

          doCheck = true;
          checkInputs = dev-tools;
          checkPhase = ''
            shellcheck $name
          '';

          installPhase = ''
            mkdir -p $out/lib 
            cp ./$name $out/lib

            mkdir -p $out/bin
            cp ./example $out/bin/$name-example
          '';
        };

        packages = {
          default = lib; 
        };
      });
}
