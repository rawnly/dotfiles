# Personal bvos variant: project names only, then bosco inside the new session.
#
# Differences from the generated `bvos`:
#   - no --worktrees: one row per project, so the list stays short
#   - --with-nth=3,4: renders the bare project name + tags (field 1 would add
#     " (bare)"). Fields must be listed here to be searchable: fzf's --nth
#     applies to the already-transformed string, so hidden fields never match.
#   - sesh -c: runs `bosco` when the session is CREATED, ignored if it exists,
#     so re-connecting to a live session doesn't re-prompt for a worktree
function bvob --description 'Pick a bvo project, connect with sesh, pick a worktree with bosco'
    set -l row (command bvo list --format tsv --limit 0 --include-cwd \
        | fzf --delimiter='\t' --with-nth=3,4 --no-sort \
              --prompt='project> ' --preview 'sesh preview {2}' $argv)
    or return

    test -z "$row"; and return

    set -l path (printf '%s' "$row" | cut -f2)
    set -l project (printf '%s' "$row" | cut -f3)

    command bvo touch "$project" >/dev/null 2>&1

    # `bosco` (no args) = pick a worktree + cd; `exec fish` keeps the pane alive
    # in the chosen worktree instead of dying when bosco returns.
    sesh connect -c bosco "$path"
end
