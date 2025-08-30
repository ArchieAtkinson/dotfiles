#! /bin/bash
set -e

apt install -y sudo

git config --global --add safe.directory $HOME

sh <(curl --proto '=https' --tlsv1.2 -L https://nixos.org/nix/install) --daemon --yes
. /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh
nix-env -iA nixpkgs.helix nixpkgs.typos-lsp nixpkgs.lazygit nixpkgs.yazi
