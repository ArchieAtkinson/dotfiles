abbr -a --position anywhere sysflake $HOME/system
fzf --fish | source

# Needs to be at the end
zoxide init fish | source

function new_direnv
    command echo "use flake" >.envrc
    command direnv allow .
end

function hibernate
    nohup hyprlock >/dev/null 2>&1 &
    sleep 1
    systemctl hibernate
end

function cd
    echo "Use z!"
end
