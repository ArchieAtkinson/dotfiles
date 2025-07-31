#! /bin/bash
set -e

# Can't use Determiate with docker for muliuser

# curl -fsSL https://install.determinate.systems/nix | sh -s -- install --determinate --no-confirm
# # sudo chown -R user /nix
# # . /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh
# sudo chown -R user /home/user
# nix shell nixpkgs#home-manager --command home-manager --flake . switch

sh <(curl --proto '=https' --tlsv1.2 -L https://nixos.org/nix/install) --no-daemon --yes
. /home/user/.nix-profile/etc/profile.d/nix.sh
echo "source /home/user/.nix-profile/etc/profile.d/nix.sh" >> ~/.bashrc
sudo mkdir -p ~/.config/nix && echo 'experimental-features = nix-command flakes' | sudo tee  ~/.config/nix/nix.conf
sudo sed -i "s|\(^Defaults\s*secure_path=\".*\)\"|\1:/home/$USER/.nix-profile/bin\"|" /etc/sudoers
sudo chmod -R 777 $HOME/.config
nix shell nixpkgs#home-manager --command home-manager --flake . switch
