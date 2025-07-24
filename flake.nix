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
      };
    };
}
