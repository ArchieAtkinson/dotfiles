fzf --fish | source
set -U fish_expand_tilde 1
set -U pure_enable_single_line_prompt true
set -U fish_transient_prompt 1
set -U pure_truncate_prompt_current_directory_keeps 1
set -U sponge_delay 5
set -U pure_enable_nixdevshell false

function fish_greeting
end

function new_direnv
    command echo "use flake" >.envrc
    command direnv allow .
end

function hibernate
    nohup hyprlock >/dev/null 2>&1 &
    sleep 1
    systemctl hibernate
end

function j
    just -g $argv
end

function reload
    source ~/.config/fish/config.fish
end

# Needs to be at the end
zoxide init fish | source
