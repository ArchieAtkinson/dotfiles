 #!/usr/bin/env bash

set -e

rm -rf rucksack

mkdir -p rucksack/dotfiles/.config

cp -rL $HOME/.config/helix rucksack/dotfiles/.config
cp -rL $HOME/.config/yazi rucksack/dotfiles/.config
cp -rL $HOME/.config/lazygit rucksack/dotfiles/.config
cp -rL $HOME/.config/zellij rucksack/dotfiles/.config

cp -r $HOME/.gitconfig rucksack/dotfiles/

cp install.sh rucksack/

