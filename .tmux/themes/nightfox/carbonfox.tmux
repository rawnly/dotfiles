#!/usr/bin/env bash
# Nightfox colors for Tmux
# Style: carbonfox
# Upstream: https://github.com/edeneast/nightfox.nvim/raw/main/extra/carbonfox/nightfox_tmux.tmux


gray="#CCCCC6"
white="#ffffff"

# t1=#FB1471
t2=#5EDAEE
t3=#E8DA7C

bg="#121212"
fg="#2b2d2F"

accent=$t2
accent_fg=$bg

tab_accent=$t3
tab_accent_fg=$bg


set -g mode-style "fg=$bg,bg=$t3"
set -g message-style "fg=$white,bg=$bg,bold"
set -g message-command-style "fg=$accent,bg=$fg"
set -g pane-border-style "fg=$fg"
set -g pane-active-border-style "fg=$t3"
set -g status "on"
set -g status-justify "centre"
set -g status-style "fg=$fg,bg=$bg"
set -g status-left-length "100"
set -g status-right-length "100"
set -g status-left-style NONE
set -g status-right-style NONE

set -g status-left "#[fg=$accent_fg,bg=$accent,bold] #S "
set -g status-right "#{prefix_highlight} #[fg=$accent,bg=$bg,nobold,nounderscore,noitalics]#[fg=$accent_fg,bg=$accent,bold] #h "

setw -g window-status-activity-style "underscore,fg=$gray,bg=$bg"
setw -g window-status-separator ""

status_bg=$bg
status_fg=$white
setw -g window-status-style "NONE,fg=$status_fg,bg=$status_bg"
setw -g window-status-format " #[default] #I #[fg=$tab_accent,bold]|#[default] #W #F "

setw -g window-status-current-format " #[fg=$tab_accent_fg,bg=$tab_accent,bold] #I #[bold]| #W "
