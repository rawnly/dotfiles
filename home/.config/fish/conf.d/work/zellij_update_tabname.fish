function _zellij_update_tabname
    if set -q ZELLIJ
        set current_dir $PWD

        # Default name if not in a git repo
        if test "$current_dir" = "$HOME"
            set tab_name "~"
        else
            set tab_name (basename "$current_dir")
        end

        # Only proceed if we are inside a Git worktree
        if git rev-parse --is-inside-work-tree >/dev/null 2>&1
            set worktree_root (git rev-parse --show-toplevel 2>/dev/null)
            set common_dir (git rev-parse --git-common-dir 2>/dev/null)
            set branch_name (git branch --show-current 2>/dev/null | cut -c1-20)

            # Get the repo name:
            # For worktrees, we go one level up from the common git dir.
            # For standard repos, it's just the basename of the worktree root.
            set repo_name (basename (realpath "$common_dir/..") .git)

            # Determine if this is a worktree/bare setup or a standard repo
            # Standard repo: common_dir is usually just ".git" or absolute path to it inside root
            # Worktree: common_dir is an absolute path elsewhere
            if string match -q "*bare*" "$common_dir"
                # Behavior: {repo name} ({branch})
                set tab_name "$repo_name ($branch_name)"
            else
                # Behavior: {repo name}
                set tab_name "$repo_name"
            end
        end

        nohup zellij action rename-tab "$tab_name" >/dev/null 2>&1 &
    end
end

function __auto_zellij_update_tabname --on-variable PWD --description "Update zellij tab name on directory change"
    _zellij_update_tabname
end

_zellij_update_tabname
