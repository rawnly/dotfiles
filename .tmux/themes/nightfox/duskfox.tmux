#!/usr/bin/env bash
# Nightfox colors for Tmux
# Style: duskfox
# Upstream: https://github.com/edeneast/nightfox.nvim/raw/main/extra/duskfox/nightfox_tmux.tmux
cyan="#569fba"
whitesmoke="#cdcbe0"

gray_0="#6e6a86"
gray_1="#393552"
gray_2="#191726"


set -g mode-style "fg=$gray_2,bg=$cyan"
set -g message-style "fg=$gray_2,bg=$whitesmoke"
set -g message-command-style "fg=$gray_2,bg=$whitesmoke"
set -g pane-border-style "fg=$whitesmoke"
set -g pane-active-border-style "fg=$cyan"
set -g status "on"
set -g status-justify "left"
set -g status-style "fg=$cyan,bg=$gray_2"
set -g status-left-length "100"
set -g status-right-length "100"
set -g status-left-style NONE
set -g status-right-style NONE
set -g status-left "#[fg=$gray_1,bg=$cyan,bold] #S #[fg=$cyan,bg=$gray_2,nobold,nounderscore,noitalics]"
set -g status-right "#[fg=$gray_2,bg=$gray_2,nobold,nounderscore,noitalics]#[fg=$cyan,bg=$gray_2] #{prefix_highlight} #[fg=$whitesmoke,bg=$gray_2,nobold,nounderscore,noitalics]#[fg=$gray_2,bg=$whitesmoke] %Y-%m-%d  %I:%M %p #[fg=$cyan,bg=$whitesmoke,nobold,nounderscore,noitalics]#[fg=$gray_1,bg=$cyan,bold] #h "

setw -g window-status-activity-style "underscore,fg=$gray_0,bg=$gray_2"
setw -g window-status-separator ""
setw -g window-status-style "NONE,fg=$gray_0,bg=$gray_2"
setw -g window-status-format "#[fg=$gray_2,bg=$gray_2,nobold,nounderscore,noitalics]#[default] #I  #W #F #[fg=$gray_2,bg=$gray_2,nobold,nounderscore,noitalics]"
setw -g window-status-current-format "#[fg=$gray_2,bg=$whitesmoke,nobold,nounderscore,noitalics]#[fg=$gray_2,bg=$whitesmoke,bold] #I  #W #F #[fg=$whitesmoke,bg=$gray_2,nobold,nounderscore,noitalics]"

