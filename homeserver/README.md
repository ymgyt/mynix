# Home Server Cluster

`nix develop -c` or `direnv allow`

## Deployment

```sh
# Deploy rpi4-01 node
deploy --skip-checks .#rpi4-01

# Deploy all node
cargo make deploy
```

Currently on x86-darwin check does not work. [issue](https://github.com/serokell/deploy-rs/issues/216)