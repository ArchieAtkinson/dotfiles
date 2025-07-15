abbr -a --position anywhere sysflake $HOME/system
fzf --fish | source

function new_direnv
    command echo "use flake" >.envrc
    command direnv allow .
end
