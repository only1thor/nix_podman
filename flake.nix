{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    disko.url = "github:nix-community/disko";
    disko.inputs.nixpkgs.follows = "nixpkgs"; # Make disk use the same nixpkgs as your config
  };

  outputs = { self, nixpkgs, disko, ... }:
  let
    system = "x86_64-linux";
  in {
    nixosConfigurations = {
      test = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          ./podman_apps_server/configuration.nix
          disko.nixosModules.disko
          ./podman_apps_server/disko-config.nix
        ];
      };
      isomini = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./bootstrap_iso/configuration.nix
          "${nixpkgs}/nixos/modules/installer/cd-dvd/installation-cd-base.nix"
        ];
      };
    };
    packages.x86_64-linux.default = self.nixosConfigurations.isomini.config.system.build.isoImage;
  };
}
