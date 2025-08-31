#!/usr/bin/env bash
set -e

git config --global --add safe.directory $HOME

if [[ "$(whoami)" == "root" ]]; then
  echo "root user detected"
  
  apt install -y sudo

  sh <(curl --proto '=https' --tlsv1.2 -L https://nixos.org/nix/install) --daemon --yes
  . /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh
else 
  echo "non root user detected"

  sh <(curl --proto '=https' --tlsv1.2 -L https://nixos.org/nix/install) --no-daemon --yes
  . /home/user/.nix-profile/etc/profile.d/nix.sh

  echo "source /home/user/.nix-profile/etc/profile.d/nix.sh" >> ~/.bashrc
  sudo sed -i "s|\(^Defaults\s*secure_path=\".*\)\"|\1:/home/$USER/.nix-profile/bin\"|" /etc/sudoers
fi

nix-env -iA nixpkgs.helix nixpkgs.typos-lsp nixpkgs.lazygit nixpkgs.yazi
