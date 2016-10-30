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
setw -g mode-attr bold
setw -g mode-fg yellow
setw -g mode-bg colour234

# }

# The panes {

set -g pane-border-bg colour235
set -g pane-border-fg colour238
set -g pane-active-border-bg colour236
set -g pane-active-border-fg colour51

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
set -g status-bg colour234
set -g status-fg colour137
set -g status-attr dim
set -g status-left $tm_user$tm_session
set -g status-right '#{prefix_highlight}'$tm_date$tm_time$tm_host
set -g status-right-length 50
set -g status-left-length 40
set -g status-interval 5

setw -g window-status-current-fg colour81
setw -g window-status-current-bg colour238
setw -g window-status-current-attr bold
setw -g window-status-current-format " $tm_sync#I#[fg=colour250]:#[fg=colour255]#W#[fg=colour50]#F "

setw -g window-status-fg colour138
setw -g window-status-bg colour235
setw -g window-status-attr none
setw -g window-status-format " $tm_sync#I#[fg=colour237]:#[fg=colour250]#W#[fg=colour244]#F "

setw -g window-status-bell-attr bold
setw -g window-status-bell-fg colour255
setw -g window-status-bell-bg colour1

# }

# The messages {

set -g message-attr bold
set -g message-fg colour81
set -g message-bg colour234
set -g message-command-fg blue
set -g message-command-bg black

# }
