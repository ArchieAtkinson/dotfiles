 #!/usr/bin/env bash

set -e

DOTFILES="/home/archie/dotfiles"


rm -r bundle

mkdir -p bundle/home/.config

nix build .#helix-deb
cp result/* bundle
cp -r $DOTFILES/helix/.config bundle/home/

nix build .#yazi-deb
cp result/* bundle
cp -r $DOTFILES/yazi/.config bundle/home/

nix build .#lazygit-deb
cp result/* bundle
cp -r $DOTFILES/lazygit/.config bundle/home/

nix build .#rsync-deb
cp result/* bundle

nix build .#typos-lsp-deb
cp result/* bundle

cp -r $DOTFILES/git bundle/home

cp install.sh bundle/

rm -r result
