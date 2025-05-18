home := "$HOME"

[no-cd, no-exit-message]
@all:
    stow --target={{home}} --restow */

    
[no-cd, no-exit-message]
@delete:
    stow --target={{home}} --delete */
    
toggle-theme:
    #!/usr/bin/env fish

    set current_scheme (gsettings get org.gnome.desktop.interface color-scheme)

    set current_scheme (string replace "'" "" $current_scheme)    
    set current_scheme (string replace "'" "" $current_scheme)

    if test "$current_scheme" = "prefer-light"
    
      sed -i 's/theme = ".*"/theme = "catppuccin_macchiato"/g' helix/.config/helix/config.toml
      sed -i 's/theme ".*"/theme "catppuccin-macchiato"/g' zellij/.config/zellij/config.kdl
      
      pkill -USR1 hx
      # Required for Ghostty and GUIs
      gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
      echo "Switched to dark mode."
      
    else if test "$current_scheme" = "prefer-dark"
    
      sed -i 's/theme = ".*"/theme = "catppuccin_latte"/g' helix/.config/helix/config.toml
      sed -i 's/theme ".*"/theme "catppuccin-latte"/g' zellij/.config/zellij/config.kdl
      
      pkill -USR1 hx
      # Required for Ghostty and GUIs
      gsettings set org.gnome.desktop.interface color-scheme 'prefer-light'
      echo "Switched to light mode."
    else
      gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
      echo "Current scheme was unexpected ($current_scheme). Defaulting to dark mode."
    end
