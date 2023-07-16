#!/usr/bin/env bash
# Nightfox colors for Tmux
# Style: nightfox
# Upstream: https://github.com/edeneast/nightfox.nvim/raw/main/extra/nightfox/nightfox_tmux.tmux
bg="#1f2430"
fg="#cbccc6"
bg2="#171b24"
accent="#ffcc66"
selection_normal="#69758c"
string="#d5ff80"

set -g mode-style "fg=$bg,bg=$fg"
set -g message-style "fg=$accent,bg=$bg2"
set -g message-command-style "fg=$bg,bg=$fg"
set -g pane-border-style "fg=$selection_normal"
set -g pane-active-border-style "fg=$accent"
set -g status "on"
set -g status-justify "left"
set -g status-style "fg=$fg,bg=$bg"
set -g status-left-length "100"
set -g status-right-length "100"
set -g status-left-style NONE
set -g status-right-style NONE

tab_bg="$bg"
tab_fg="$fg"

active_tab_bg="$string"
active_tab_fg="$bg"

branch_bg="$accent"
branch_fg="$bg"

hostname_bg="$accent"
hostname_fg="$bg"

prefix_highlight_fg="$string"
prefix_highlight_bg="$bg"

set -g @prefix_highlight_fg "$prefix_highlight_fg" # default is 'colour231'
set -g @prefix_highlight_bg "$prefix_highlight_bg" # default is 'colour04'

set -g @prefix_highlight_prefix_prompt "Wait"
set -g @prefix_highlight_copy_prompt "Copy"
set -g @prefix_highlight_sync_prompt "Sync"

set -g @prefix_highlight_show_copy_mode 'on'
set -g @prefix_highlight_copy_mode_attr 'fg=black,bg=yellow,bold' # default is 'fg=default,bg=yellow'
set -g @prefix_highlight_show_sync_mode 'on'
set -g @prefix_highlight_sync_mode_attr 'fg=black,bg=green' # default is 'fg=default,bg=yellow'

set -g status-left "#[fg=$branch_fg,bg=$branch_bg,bold] #S #[fg=$branch_bg,bg=$bg,nobold,nounderscore,noitalics]"
set -g status-right "#[fg=$bg,bg=$bg,nobold,nounderscore,noitalics]#[fg=$bg,bg=$bg] #{prefix_highlight} #[fg=$hostname_bg,bg=$bg,nobold,nounderscore,noitalics]#[fg=$hostname_fg,bg=$hostname_bg,bold] #h "

setw -g window-status-activity-style "underscore,fg=$fg,bg=$bg"
setw -g window-status-separator ""
setw -g window-status-style "NONE,fg=$tab_fg,bg=$tab_bg"
setw -g window-status-format "#[fg=$bg,bg=$bg,nobold,nounderscore,noitalics]#[default] #I  #W #[fg=$tab_bg,bg=$tab_bg,nobold,nounderscore,noitalics]"
setw -g window-status-current-format "#[fg=$bg,bg=$active_tab_bg,nobold,nounderscore,noitalics]#[fg=$active_tab_fg,bg=$active_tab_bg,bold] #I  #W #[fg=$active_tab_bg,bg=$bg,nobold,nounderscore,noitalics]"
