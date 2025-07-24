# Quick setup/disaster recovery

1. Boot from the recovery iso with preloaded ssh keys.
2. Then from the root of this repo run: `nixos-anywhere --flake .#test root@192.168.122.141`

## Updating docker-compose.yaml/nix
to generate docker-compose.nix use:
`nix run github:aksiksi/compose2nix -- -project=testpods`

## Building boot[strap] iso
build minimal iso with preloaded ssh keys:

`nix build .#nixosConfigurations.isomini.config.system.build.isoImage`