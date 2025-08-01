home := "$HOME"
set shell := ["fish", "-c"]
    
[no-cd, no-exit-message]
@all:
    stow --target={{home}} --restow */

    
[no-cd, no-exit-message]
@delete:
    stow --target={{home}} --delete */

waybar-restart:
    kill -SIGUSR2 .waybar-wrapped

[working-directory: 'home-manager', no-exit-message]
@switch:
    home-manager --flake . switch

[no-cd, no-exit-message]
@dark-theme:
    # Helix
    sed -i 's/theme = ".*"/theme = "catppuccin_macchiato"/g' helix/.config/helix/config.toml
    pkill -USR1 hx

    # Zellij
    sed -i 's/theme ".*"/theme "catppuccin-macchiato"/g' zellij/.config/zellij/config.kdl

    # Bat
    sed -i 's/theme=".*"/theme="Catppuccin Macchiato"/g' bat/.config/bat/config
    
    # Required for Ghostty and GUIs
    gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
    echo "Switched to dark mode."
      
[no-cd, no-exit-message]
@light-theme:
    # Helix
    sed -i 's/theme = ".*"/theme = "catppuccin_latte"/g' helix/.config/helix/config.toml
    pkill -USR1 hx

    # Zellij
    sed -i 's/theme ".*"/theme "catppuccin-latte"/g' zellij/.config/zellij/config.kdl

    
    # Bat
    sed -i 's/theme=".*"/theme="Catppuccin Latte"/g' bat/.config/bat/config
    
    # Required for Ghostty and GUIs
    gsettings set org.gnome.desktop.interface color-scheme 'prefer-light'
    echo "Switched to light mode."

[no-cd, no-exit-message]
toggle-theme:
    #!/usr/bin/env fish

    set current_scheme (gsettings get org.gnome.desktop.interface color-scheme)
    if test "$current_scheme" = "'prefer-light'"
        just dark-theme     
    else if test "$current_scheme" = "'prefer-dark'"
        just light-theme
    else
      gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
      echo "Current scheme was unexpected ($current_scheme). Defaulting to dark mode."
    end
