set -l p "$HOME/.cargo/env.fish"

if test -f "$p"
    source "$p"
end

eval (rustup completions fish)
