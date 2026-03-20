#!/usr/bin/env bash
 

if [[ ${USER:-root} == "root" ]]; then
  for deb in *.deb; do
    dpkg --force-overwrite -i "$deb"
  done
else
  for deb in *.deb; do
    sudo dpkg --force-overwrite -i "$deb"
  done
fi

mkdir -p $HOME/.config
rsync -Ra home $HOME
