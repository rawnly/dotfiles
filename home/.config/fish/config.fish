set fish_greeting

set -gx EDITOR nvim
set -gx MCFLY_KEY_SCHEME vim
set -gx MANPAGER 'nvim +Man!'

set -gx BRACCO_VIM true
set -gx BRACCO_PREVIEW 'bat --theme luna -p {}'

set -gx OP_BIOMETRIC_UNLOCK_ENABLED true
set ZELLIJ_AUTO_EXIT true
set ZELLIJ_CONFIG_DIR "$HOME/.config/zellij"
set ZELLIJ_AUTO_ATTACH false
set ZELLIJ_ENABLED false
set -gx HOMEBREW_CASK_OPTS "--appdir=$HOME/Applications"

set TMUX_ENABLED false
set TMUX_DEFAULT_SESSION main
set HERDR_ENABLED false

set -x GOPATH $HOME/.go
set -g FZF_DEFAULT_OPTS "--height 40%" --border --layout=reverse

if test -e $__fish_config_dir/profile.fish
    source $__fish_config_dir/profile.fish
end

source $__fish_config_dir/_load_extra.fish

if status is-interactive
    if test "$TERM_PROGRAM" = rex
        set -g fish_handle_reflow 0
    end

    if test "$ZELLIJ_ENABLED" = true
        if [ "$TERM" = xterm-ghostty ]
            if not set -q ZELLIJ
                if test "$ZELLIJ_AUTO_ATTACH" = true
                    zellij attach -c main
                else
                    zellij -l compact
                end

                if test "$ZELLIJ_AUTO_EXIT" = true
                    kill $fish_pid
                end
            end
        end
    end

    if test "$TMUX_ENABLED" = true
        if not set -q TMUX
            exec sesh connect $(
            sesh list --icons | fzf-tmux -p 80%,70% \
              --no-sort --ansi --border-label ' sesh ' --prompt '⚡  ' \
              --header '  ^a all ^t tmux ^g configs ^x zoxide ^d tmux kill ^f find' \
              --bind 'tab:down,btab:up' \
              --bind 'ctrl-a:change-prompt(⚡  )+reload(sesh list --icons)' \
              --bind 'ctrl-t:change-prompt(🪟  )+reload(sesh list -t --icons)' \
              --bind 'ctrl-g:change-prompt(⚙️  )+reload(sesh list -c --icons)' \
              --bind 'ctrl-x:change-prompt(📁  )+reload(sesh list -z --icons)' \
              --bind 'ctrl-f:change-prompt(🔎  )+reload(fd -H -d 2 -t d -E .Trash . ~)' \
              --bind 'ctrl-d:execute(tmux kill-session -t {2..})+change-prompt(⚡  )+reload(sesh list --icons)' \
              --preview-window 'right:55%' \
              --preview 'sesh preview {}'
          )
        end
    end

    if test "$HERDR_ENABLED" = true
        if not set -q HERDR_ENV
            exec herdr session attach default
        end
    end

    # Deferred Inits
    function _defer_mise --on-event fish_prompt
        mise activate fish | source
        functions -e _defer_mise
    end
end

# Only add paths if they aren't already there (avoids reconstruction on every subshell)
if not set -q __fish_initialized
    fish_add_path \
        /opt/homebrew/bin \
        ~/shell/bin \
        ~/shell/git-commands \
        ~/Developer/scripts \
        ~/.cargo/bin \
        ~/.go/bin \
        ~/go/bin \
        ~/.local/bin \
        /opt/homebrew/opt/swift/bin \
        ~/.codeium/windsurf/bin \
        ~/.opencode/bin \
        /opt/zerobrew/prefix/bin

    set -gx __fish_initialized 1
end

# herdr-automatic-rename: live tab naming hook
for _f in $HOME/.config/herdr/plugins/github/herdr-automatic-rename-*/shell/hook.fish
    test -r "$_f"; and source "$_f"; and break
end
# >>> mise:activate >>> managed by mise — do not edit between markers
mise activate fish | source
# <<< mise:activate <<<
