#!/usr/bin/env sh

thm_bg="#000000"
thm_fg="#c1c1c1"
thm_black="#000000"
thm_blue="#888888"
thm_pink="#aaaaaa"
thm_green="#fbcb97"
thm_magenta="#999999"
thm_red="#5f8787"
thm_gray="#c1c1c1"
thm_orange="#e78a53"
thm_white="$thm_fg"

set -g status-position bottom
set -g status-justify centre
set -g status-style "bg=$thm_bg"
set -g window-style ""
set -g window-active-style ""

thm_light_bg="$thm_white"

set-window-option -gq window-status-activity-style "fg=${thm_fg},bg=${thm_bg},none"
set-window-option -gq window-status-separator ""
set-window-option -gq window-status-style "fg=${thm_fg},bg=${thm_bg},none"

rs_fg="$thm_bg"
rs_bg="$thm_orange"

set-option -gq status-left "#[fg=$thm_fg,bg=$thm_bg] #{b:pane_index}"
set-option -gq status-right "#[fg=$rs_bg,bg=$thm_bg,nobold,nounderscore,noitalics]#[fg=$thm_bg,bg=$rs_bg,nobold,nounderscore,noitalics] #[fg=$sr_fg,bg=$rs_bg] #W
#{?client_prefix,#[bg=$rs_bg],#[bg=$rs_bg]}#[fg=$thm_bg] #[fg=$sr_fg,bg=$rs_bg] #S "

# current_dir
set-window-option -gq window-status-format "#[fg=$thm_bg,bg=$thm_light_bg] #I #[fg=$thm_fg,bg=$thm_bg] #{b:pane_current_path} "
set-window-option -gq window-status-current-format "#[fg=$thm_bg,bg=$thm_orange] #I #[fg=$thm_orange,bg=$thm_bg] #{b:pane_current_path} "

