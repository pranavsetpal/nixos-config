# Personal NixOS Config

## To Update
Either run
```shell
cd ~/.nixos/
doas nix flake update
doas nixos-rebuild switch --flake .#portable
home-manager switch --flake .
```
or the alias
```shell
nixos-update (sources/os/home/all) # Leaving blank updates everything
```

