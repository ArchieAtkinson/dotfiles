 #!/usr/bin/env bash

set -e

if [[ ${USER:-root} == "root" ]]; then
  echo "root user detected"

  export USER=root
  
  apt-get update && apt-get install -y curl xz-utils

  sh <(curl --proto '=https' --tlsv1.2 -L https://nixos.org/nix/install) --daemon --yes
  . /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh
else 
  echo "non root user detected"
  
  sudo apt-get update && sudo apt-get install -y curl xz-utils

  sh <(curl --proto '=https' --tlsv1.2 -L https://nixos.org/nix/install) --no-daemon --yes
  . /home/user/.nix-profile/etc/profile.d/nix.sh

  echo "source /home/user/.nix-profile/etc/profile.d/nix.sh" >> ~/.bashrc
  sudo sed -i "s|\(^Defaults\s*secure_path=\".*\)\"|\1:/home/$USER/.nix-profile/bin\"|" /etc/sudoers
fi

git config --global --add safe.directory $HOME

nix-env -iA nixpkgs.helix \
  nixpkgs.yazi \
  nixpkgs.lazygit \
  nixpkgs.typos-lsp \
  nixpkgs.zellij

export EDITOR=hx

cp -r dotfiles/. $HOME/
