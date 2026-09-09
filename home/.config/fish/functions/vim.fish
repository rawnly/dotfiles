function fvim
    if test (count $argv) -eq 0
        fd -t f | fzf --header "Open File in Vim" --preview "bat -p --color=always {}" | xargs nvim
    else
        set -l query (string join " " $argv)
        fd -t f | fzf --header "Open File in Vim" -q "$query" --preview "bat -p --color=always {}" | xargs nvim
    end
end

function vim
    if test (count $argv) -eq 0
        nvim .
    else
        nvim $argv
    end
end

function vi
    if test (count $argv) -eq 0
        nvim .
    else
        nvim $argv
    end
end
