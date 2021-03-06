#!/bin/sh
# ====================================================================
# This is the tmux configuration I use for setting up my Ruby on Rails 
# Tutorial session
# 

# export TERM=screen-256color-bce 
#export TERM=screen-256color

BASE="$HOME/Projects/Rails/rails42tutorial/sample_app"
cd $BASE

tmux start-server

# new-session creates first window named 'rails'
tmux new-session -d -s sampleapp -n rails

# split window 'h'orizontally (into two vertical panes)
tmux split-window -t sampleapp:rails -h

# select the left-most pane
tmux last-pane

# split this pane 'v'ertically (into two horizontal panes)
tmux split-window -t sampleapp:rails -v

# create a second window for 'logs'
tmux new-window -t sampleapp:2 -n logs

# start a vim editor in the left-most vertical pane
tmux send-keys -t sampleapp:rails.2 "cd $BASE; vim" C-m

# widen the vim editor pane by 20 cells
tmux resize-pane -L -t sampleapp:rails.2 20

# run guard -c clears shell after each change
tmux send-keys -t sampleapp:rails.0 "cd $BASE; guard -c" C-m

# start rails server
tmux send-keys -t sampleapp:rails.1 "cd $BASE; rails s" C-m

# start logging
tmux send-keys -t sampleapp:logs "cd $BASE; tail -f log/*.log" C-m

# select the vim pane in the rails window
tmux select-window -t sampleapp:rails
tmux select-pane -t sampleapp:rails.2

# make the tmux session active
tmux attach-session -d -t sampleapp
