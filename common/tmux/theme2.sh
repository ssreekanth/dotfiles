######################
### DESIGN CHANGES ###
######################

# loud or quiet?
set-option -g visual-activity off
set-option -g visual-bell off
set-option -g visual-silence off
set-window-option -g monitor-activity off
set-option -g bell-action none

# The modes {

setw -g clock-mode-colour colour135
setw -g mode-style fg=yellow,bg=colour234,bold

# }

# The panes {

set -g pane-border-style bg=colour235,fg=colour238
set -g pane-active-border-style bg=colour236,fg=colour51

# }

# The statusbar {

tm_user='#[fg=brightgreen,bold]♟ #(whoami) '
tm_session='(#[fg=colour81]#S#[fg=brightgreen,bold]) '
tm_time='#[fg=colour233,bg=colour245,bold] %H:%M:%S '
tm_date='#[fg=colour233,bg=colour241,bold] %d %b %Y ' # %m/%d/%Y'
tm_host='#[fg=brightred,bg=colour234,bold] #h '
tm_sync='#{?pane_synchronized,⛓ ,}'

set -g @prefix_highlight_show_copy_mode 'on'
set -g @prefix_highlight_copy_mode_attr 'fg=black,bg=yellow,bold'

set -g status-position bottom
set -g status-justify left
set -g status-style bg=colour234,fg=colour137,dim
set -g status-left $tm_user$tm_session
set -g status-right '#{prefix_highlight}'$tm_date$tm_time$tm_host
set -g status-right-length 60
set -g status-left-length 40
set -g status-interval 5

setw -g window-status-current-style fg=colour81,bg=colour238,bold
setw -g window-status-current-format " $tm_sync#I#[fg=colour250]:#[fg=colour255]#W#[fg=colour50]#F "

setw -g window-status-style fg=colour138,bg=colour235,none
setw -g window-status-format " $tm_sync#I#[fg=colour237]:#[fg=colour250]#W#[fg=colour244]#F "

setw -g window-status-bell-style bold,fg=colour255,bg=colour1

# }

# The messages {

set -g message-style bold,fg=colour81,bg=colour234
set -g message-command-style fg=blue,bg=black

# }
