# mynix

My Nix configuration

## Getting started

1. Install nix (and enable flake if needed)
2. Clone this repository

```sh
nix run nixpkgs#git -- clone https://github.com/ymgyt/mynix.git
```

3. Run task
```sh
nix shell nixpkgs#cargo-make -c makers `apply`
```

## Tasks

```sh
# Apply host nixos/darwin configuration
# Make sure $(hostname) match the osConfiguration target
makers apply

# Format
makers format
```