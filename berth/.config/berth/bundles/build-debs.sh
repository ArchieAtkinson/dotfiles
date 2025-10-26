#!/bin/sh
mkdir packages

nix build .#helix-deb
cp result/* packages

nix build .#yazi-deb
cp result/* packages

nix build .#lazygit-deb
cp result/* packages

nix build .#typos-lsp-deb
cp result/* packages

rm -r result
