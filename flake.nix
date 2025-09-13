{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{
      self,
      nixpkgs,
      flake-parts,
    }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [
        "x86_64-linux"
        "aarch64-darwin"
      ];
      perSystem =
        {
          self',
          pkgs,
          ...
        }:
        {
          packages = {
            default = self'.packages._3x-ui;
            _3x-ui = pkgs.callPackage ./3x-ui.nix {
              inherit (self'.packages) xray;
            };
            xray = pkgs.callPackage ./xray.nix { };
          };
        };
    };
}
