# Nyx — auto-generated, do not edit.
# OSC 7 (CWD reporting) and OSC 133 D (command completion) for fish shell.
# ── Nyx control-credential fence ──────────────────────────
# A multiplexer server captures the environment of the client that
# STARTED it and applies that as the global environment of every pane it
# creates afterwards — in every session, for the life of the server. The
# variables below are the control-plane credential, minted per terminal,
# so a pane opened from one workspace would otherwise carry another
# workspace's authority and drive its windows.
#
# tmux's `update-environment` cannot fix this: it rewrites a fixed list
# of variables, and only for panes created after an attach. A pane that
# already existed can never be corrected.
#
# So a multiplexer pane gets NO authority rather than someone else's.
# `vesper` then reports that it is not running inside a Nyx terminal,
# which is true and actionable.
if test -n "$TMUX"; or test -n "$STY"; or test -n "$ZELLIJ"
    set -e VESPER_APP_VERSION; set -e VESPER_BROWSER_MCP_COMMAND; set -e VESPER_CLI; set -e VESPER_SOCKET; set -e VESPER_STARSHIP; set -e VESPER_TERMINAL_ID; set -e VESPER_TERMINAL_SECRET; set -e VESPER_WORKSPACE_ID; set -e VESPER_WORKSPACE_TOKEN
end

# Where this instance's integration lives. Fish has no POSIX
# ${VAR:-default}, so the fallback is spelled out once here rather than
# inline at each use — an unparseable expansion would stop this whole
# file loading, taking theme refresh, prompt markers, PATH and the AI
# wrappers with it.
# Global, not local: fish drops a `set -l` when this file finishes
# sourcing, and the functions defined below do not capture it — so the
# prompt event's theme refresh and the AI wrappers would look under a
# bare "/state/theme" and "/bin/vesper-ai" when they actually run.
set -g _vesper_cfg $VESPER_CONFIG_DIR
if test -z "$_vesper_cfg"
    set -g _vesper_cfg "$HOME/.config/vesper"
end

# fish 4 emits its own OSC 133 A/B/C/D marks; emitting ours as well
# would double-count every command (AUT-1859). OSC 7 stays: fish
# omits it. $version is set by fish itself ("4.9.3"-shaped), so this
# needs no subprocess and no PATH lookup for the fish binary.
# Global like _vesper_cfg above: the event handlers below run later
# and do not capture locals.
set -g _vesper_native_marks 0
if string match -qr '^([4-9]|\d\d+)\.' -- "$version"
    set -g _vesper_native_marks 1
end

function __vesper_refresh_theme_env
    set -l _v_theme "$_vesper_cfg/state/theme"
    if test -f "$_v_theme"
        while read -l line
            set -l parts (string split -m1 '=' -- $line)
            set -l key $parts[1]
            set -l value $parts[2]
            switch $key
                case COLORFGBG VESPER_THEME_MODE VESPER_MATERIAL_MODE VESPER_THEME_NAME VESPER_TERMINAL_BG VESPER_TERMINAL_FG VESPER_BACKGROUND VESPER_SURFACE VESPER_ACCENT
                    set -gx $key "$value"
            end
        end < "$_v_theme"
    end
    # See the zsh block: recover when the app had no answer yet.
    if not test -x "$VESPER_CLI"
        # Nyx's own bin, not a PATH lookup — see the zsh block.
        if test -x '/Users/federico.vitale/.config/vesper/bin/vesper'
                    set -gx VESPER_CLI '/Users/federico.vitale/.config/vesper/bin/vesper'
                end
    end
    if set -q VESPER_SOCKET; and set -q VESPER_WORKSPACE_TOKEN; and test -x "$VESPER_CLI"
        for line in ("$VESPER_CLI" theme --env 2>/dev/null)
            set -l parts (string split -m1 '=' -- $line)
            set -l key $parts[1]
            set -l value $parts[2]
            switch $key
                case COLORFGBG VESPER_THEME_MODE VESPER_MATERIAL_MODE VESPER_THEME_NAME VESPER_TERMINAL_BG VESPER_TERMINAL_FG VESPER_BACKGROUND VESPER_SURFACE VESPER_ACCENT
                    set -gx $key "$value"
            end
        end
    end
end

function __vesper_postexec --on-event fish_postexec
    if test "$_vesper_native_marks" = 0
        printf '\e]133;D;%d\a' $status
    end
end

# Command start: the one place for work that must happen just before
# a command line runs. fish calls it once per submitted line, before
# any of it executes, in this shell, so state it changes is what the
# command sees. It marks where the command's output begins (OSC 133
# C). AUT-350 and AUT-528 (STARSHIP_CONFIG unexported while a command
# runs, re-exported at the prompt) add their work here, not a new
# hook. zsh (`_vesper_preexec`) and bash carry the same seam.
# fish also signals a line of nothing but spaces, which runs nothing;
# zsh and bash do not, so neither does this.
function __vesper_preexec --on-event fish_preexec
    string match -qr '\S' -- "$argv[1]"; or return
    if test "$_vesper_native_marks" = 0
        printf '\e]133;C\a'
    end
end

function __vesper_precmd --on-event fish_prompt
    __vesper_refresh_theme_env
    printf '\e]7;file://%s%s\a' (hostname) (pwd)
    if test "$_vesper_native_marks" = 0
        printf '\e]133;A\a'
    end
end

set -gx GPG_TTY (tty)
if test -d "$_vesper_cfg/bin"; and not contains "$_vesper_cfg/bin" $PATH
    set -gx PATH "$_vesper_cfg/bin" $PATH
end
# Starship prompt
set -q STARSHIP_CONFIG; or set -gx STARSHIP_CONFIG "$_vesper_cfg/starship.toml"
# See the zsh block: the app resolved this, so shell and Settings
# cannot disagree about whether Starship is available.
# See the zsh block.
if not test -x "$VESPER_STARSHIP"
    set -gx VESPER_STARSHIP (command -v starship 2>/dev/null)
end
if test -n "$VESPER_STARSHIP" -a -x "$VESPER_STARSHIP"
    "$VESPER_STARSHIP" init fish | source
end
# AI CLI wrappers — see the zsh wrapper section for the full
# rationale. Nyx types just `claude --…\r` etc; these wrappers
# route that to `vesper-ai`. Defined unconditionally inside Nyx
# terminals so a bare name never escapes the wrapper.

# Helper: is `$argv[1]` an executable file on PATH? Iterate PATH
# directly so the wrapper functions don't recurse into themselves
# via `command -v` / `command -q` — both find function definitions
# in fish.
function _vesper_path_binary
    for _v_dir in $PATH
        if test -x "$_v_dir/$argv[1]"
            return 0
        end
    end
    return 1
end

# AI CLI wrappers. See the zsh block: `vesper-ai` is the one place
# that resolves a provider binary, and there is deliberately no
# second path here that could disagree with it.
if test -n "$VESPER_TERMINAL_ID"
    function _vesper_ai
        set -l _v_cli $argv[1]
        set -e argv[1]
        set -l _v_launcher "$_vesper_cfg/bin/vesper-ai"
        if test -x "$_v_launcher"
            command "$_v_launcher" $_v_cli $argv
            return $status
        end
        echo "Nyx: the AI launcher is missing at $_v_launcher. Restart Nyx to reinstall it."
        return 1
    end

    function claude
        _vesper_ai claude $argv
    end
    function agent
        _vesper_ai cursor $argv
    end
    function cursor-agent
        _vesper_ai cursor $argv
    end
    function gemini
        _vesper_ai gemini $argv
    end
    function codex
        _vesper_ai codex $argv
    end
    function opencode
        _vesper_ai opencode $argv
    end
    function grok
        _vesper_ai grok $argv
    end
    function pi
        _vesper_ai pi $argv
    end
    function muse
        _vesper_ai muse $argv
    end
    function hermes
        _vesper_ai hermes $argv
    end
end

# Report integration health back to the app via OSC 7777
if status is-interactive
    printf '\e]7777;prompt=%s\a' "Starship"
end