{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/release-23.05";
  };

  outputs = { self, nixpkgs }: {

    packages.aarch64-darwin.default =
      let toml = (nixpkgs.legacyPackages.aarch64-darwin.formats.toml { }).generate "foo.toml" { };
      in
      nixpkgs.legacyPackages.aarch64-darwin.stdenv.mkDerivation {
        name = "toml-bug";
        src = ./.;
        installPhase = ''
          cp ${toml} $out/foo.toml
        '';
      };

  };
}
