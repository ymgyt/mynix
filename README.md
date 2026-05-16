# mynix

My Nix configuration

## Getting started

1. Install nix (and enable flakes if needed)
2. Clone this repository

```sh
nix run nixpkgs#git -- clone https://github.com/ymgyt/mynix.git
```

3. Run task

```sh
nix shell nixpkgs#just -c just apply
```

## Tasks

```sh
# Apply nixos/darwin configuration (defaults to $(hostname))
just apply
just apply xps15   # explicit host

# List available recipes
just

# Format nix files
just fmt

# Run flake check
just check

# Update nixpkgs
just update

# Garbage collect
just gc
```
