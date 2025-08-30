#! /bin/bash
set -e

git config --global --add safe.directory $HOME

sh <(curl --proto '=https' --tlsv1.2 -L https://nixos.org/nix/install) --no-daemon --yes
. /home/user/.nix-profile/etc/profile.d/nix.sh
echo "source /home/user/.nix-profile/etc/profile.d/nix.sh" >> ~/.bashrc
sudo sed -i "s|\(^Defaults\s*secure_path=\".*\)\"|\1:/home/$USER/.nix-profile/bin\"|" /etc/sudoers
nix-env -iA nixpkgs.helix nixpkgs.typos-lsp nixpkgs.lazygit nixpkgs.yazi
