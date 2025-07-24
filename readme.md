# Quick setup/disaster recovery

1. Boot from the recovery iso with preloaded ssh keys.
2. Then from the root of this repo run: `nixos-anywhere --flake .#test --generate-hardware-config nixos-generate-config ./podman_apps_server/hardware-configuration.nix root@192.168.122.141`

## Updating docker-compose.yaml/nix
to generate docker-compose.nix use:
`nix run github:aksiksi/compose2nix -- -project=testpods`

## Building boot[strap] iso
build minimal iso with preloaded ssh keys:

`nix build .#nixosConfigurations.isomini.config.system.build.isoImage`


### Resources
- https://haseebmajid.dev/posts/2024-02-04-how-to-create-a-custom-nixos-iso/
- https://ash64.eu/blog/2022/building-custom-nixos-isos/
- https://github.com/nix-community/nixos-anywhere/blob/main/docs/quickstart.md