 #!/usr/bin/env bash

set -e

DOTFILES="/home/archie/dotfiles"

mkdir -p bundle/.config

nix build .#helix-deb
cp result/* bundle
cp -r $DOTFILES/helix/.config bundle/.config

nix build .#yazi-deb
cp result/* bundle
cp -r $DOTFILES/yazi/.config bundle/.config

nix build .#lazygit-deb
cp result/* bundle
cp -r $DOTFILES/lazygit/.config bundle/.config

nix build .#typos-lsp-deb
cp result/* bundle

cp install.sh bundle/

rm -r result
