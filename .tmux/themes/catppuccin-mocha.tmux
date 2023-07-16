#!/usr/bin/env bash

# NOTE: you can use vars with $<var> and ${<var>} as long as the str is double quoted: ""
# WARNING: hex colors can't contain capital letters

# --> Catppuccin (Mocha)
thm_bg="#1e1e2e"
thm_fg="#cdd6f4"
thm_cyan="#89dceb"
thm_black="#181825"
thm_gray="#313244"
thm_magenta="#cba6f7"
thm_pink="#f5c2e7"
thm_red="#f38ba8"
thm_green="#a6e3a1"
thm_yellow="#f9e2af"
thm_blue="#89b4fa"
thm_orange="#fab387"
thm_black4="#585b70"

# ----------------------------=== Theme ===--------------------------

# status
set-option -gq status "on"
set-option -gq status-bg "${thm_bg}"
set-option -gq status-justify "left"
set-option -gq status-left-length "100"
set-option -gq status-right-length "100"

# messages
set-option -gq message-style "fg=${thm_cyan},bg=${thm_gray},align=centre"
set-option -gq message-command-style "fg=${thm_cyan},bg=${thm_gray},align=centre"

# panes
set-option -gq pane-border-style "fg=${thm_gray}"
set-option -gq pane-active-border-style "fg=${thm_blue}"

# windows
set-window-option -gq window-status-activity-style "fg=${thm_fg},bg=${thm_bg},none"
set-window-option -gq window-status-separator ""
set-window-option -gq window-status-style "fg=${thm_fg},bg=${thm_bg},none"

# --------=== Statusline

set-option -gq status-left ""
set-option -gq status-right "#[fg=$thm_pink,bg=$thm_bg,nobold,nounderscore,noitalics]#[fg=$thm_bg,bg=$thm_pink,nobold,nounderscore,noitalics] #[fg=$thm_fg,bg=$thm_gray] #W #{?client_prefix,#[fg=$thm_red],#[fg=$thm_green]}#[bg=$thm_gray]#{?client_prefix,#[bg=$thm_red],#[bg=$thm_green]}#[fg=$thm_bg] #[fg=$thm_fg,bg=$thm_gray] #S "

# current_dir
set-window-option -gq window-status-format "#[fg=$thm_bg,bg=$thm_blue] #I #[fg=$thm_fg,bg=$thm_gray] #{b:pane_current_path} "
set-window-option -gq window-status-current-format "#[fg=$thm_bg,bg=$thm_orange] #I #[fg=$thm_fg,bg=$thm_bg] #{b:pane_current_path} "

# parent_dir/current_dir
# set-window-option -gq window-status-format "#[fg=colour232,bg=colour111] #I #[fg=colour222,bg=colour235] #(echo '#{pane_current_path}' | rev | cut -d'/' -f-2 | rev) "
# set-window-option -gq window-status-current-format "#[fg=colour232,bg=colour208] #I #[fg=colour255,bg=colour237] #(echo '#{pane_current_path}' | rev | cut -d'/' -f-2 | rev) "

# --------=== Modes
set-window-option -gq clock-mode-colour "${thm_blue}"
set-window-option -gq mode-style "fg=${thm_pink} bg=${thm_black4} bold"
