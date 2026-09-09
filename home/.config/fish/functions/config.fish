function config -a config_dir -d "Open a `~/.config/{config_dir}`"
    if test (count $argv) -eq 0
        set -l name (fd -t d . ~/.config -H --max-depth 1 | path basename | fzf \
            --prompt '  ' \
            --header ' Open config' \
            --border rounded \
            --height 60% \
            --layout reverse \
            --pointer '▶' \
            --preview 'eza --tree --level=2 --icons --color=always --group-directories-first ~/.config/{}' \
            --preview-window right:60%)
        if test -z "$name"
            return 1
        end
        nvim -n -c "cd ~/.config/$name" ~/.config/$name
        return
    end

    if ! test -d ~/.config/$config_dir
        echo "Unknown config: $config_dir" >&2
        return 1
    end

    nvim -n -c "cd ~/.config/$config_dir" ~/.config/$config_dir
end
