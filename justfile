# Mynix - Nix configuration for ymgyt's hosts
# https://github.com/casey/just

# List all available recipes
default:
    @just --list

# Apply nixos/darwin configuration for HOST (defaults to current hostname)
apply host=`hostname`:
    #!/usr/bin/env bash
    set -euo pipefail
    platform=$(nix eval --impure --raw ".#lib.hosts.{{ host }}.platform")
    case "${platform}" in
      nixos)
        sudo nixos-rebuild switch --flake ".#{{ host }}" --show-trace --impure
        ;;
      darwin)
        nix build ".#darwinConfigurations.{{ host }}.system"
        sudo ./result/sw/bin/darwin-rebuild switch --flake ".#{{ host }}"
        ;;
      *)
        echo "unknown platform: ${platform}" >&2
        exit 1
        ;;
    esac

# Format all nix files
fmt:
    nix fmt .

# Run flake check across all hosts
check:
    nix flake check --impure --all-systems

# Update nix flakes
update *inputs="nixpkgs home-manager myhelix":
    nix flake update {{ inputs }}

# Garbage collect old generations and store
gc:
    sudo nix profile wipe-history --profile /nix/var/nix/profiles/system --older-than 7d
    sudo nix store gc --debug

# Remove result symlink
clean:
    rm -rf result
