{
  description = "Reproduction of a bug";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/release-23.05";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, flake-utils, nixpkgs }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        toml = (pkgs.formats.toml { }).generate "foo.toml" { };
      in
      {
        packages.default = pkgs.stdenv.mkDerivation {
          name = "toml-bug";
          src = ./.;
          installPhase = ''
            cp ${toml} $out/foo.toml
          '';
        };
      }
    );
}
