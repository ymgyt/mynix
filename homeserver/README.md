# Home Server Cluster

`nix develop -c nu` or `direnv allow`

## Deployment

```sh
# Deploy rpi4-01 node
deploy --skip-checks .#rpi4-01

# Deploy all node
makers deploy
```

Currently on x86-darwin check does not work. [issue](https://github.com/serokell/deploy-rs/issues/216)


## SSH to raspi hosts

```sh
makers ssh
```


## Development

```sh
# Run formatter
makers fmt
```


## Kubernetes

reset to clean state

```sh
sudo rm -rf  /var/lib/kubernetes/ /var/lib/etcd/ /var/lib/cfssl/ /var/lib/kubelet/ /etc/kube-flannel/ /etc/kubernetes/
```