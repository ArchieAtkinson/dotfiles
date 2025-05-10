home := "$HOME"

[no-cd, no-exit-message]
@all:
    stow --target={{home}} --restow */

    
[no-cd, no-exit-message]
@delete:
    stow --target={{home}} --delete */
    
