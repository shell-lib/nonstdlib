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
        package-name = "nonstdlib.sh";
        run-dependencies = with pkgs; [];
      in rec {
        devShell = pkgs.mkShell {
          buildInputs = [
            pkgs.shellcheck
            pkgs.shfmt
          ];
        };

        defaultPackage = pkgs.writeShellApplication {
          name = package-name;
          runtimeInputs = run-dependencies;
          text = (builtins.readFile ./${package-name});
        };
      });
}
