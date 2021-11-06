#!/usr/bin/env bash
# Based on https://gist.github.com/lbonn/89d064cde963cfbacabd77e0d3801398 

set -euo pipefail

tree=$(swaymsg -t get_tree)
readarray -t win_ids <<< "$(jq -r '.. | objects | select(has("app_id")) | .id' <<< "$tree")"
readarray -t win_names <<< "$(jq -r '.. | objects | select(has("app_id")) | .name' <<< "$tree")"
readarray -t win_types <<< "$(jq -r '.. | objects | select(has("app_id")) | .app_id // .window_properties.class' <<< "$tree")"
focus_win_id=$(jq -r '.. | objects | select(has("app_id")) | select(.focused == true) | .id' <<< "$tree")


switch () {
    local k
    read -r k
    swaymsg "[con_id=${win_ids[$k]}] focus"
}

for k in $(seq 0 $((${#win_ids[@]} - 1))); do
  workspace=$(jq -r --argjson ID "${win_ids[$k]}" '.. | objects | select(has("nodes")) | select(.nodes[].id == $ID ) | .name' <<< "$tree")
  # move up tree until its not null, AND HOPE TO GOD THAT IS THE WORKSPACE -- seriouesly dude, redo this in python, where i3ipc gives way better info about containers 
  
  # for floating windows 
  if [[ "$workspace" == "" ]]; then 
    workspace=$(jq -r --argjson ID "${win_ids[$k]}" '.. | objects | select(has("floating_nodes")) | select(.floating_nodes[].id == $ID ) | .name' <<< "$tree") 
    if [[ "$workspace" == "__i3_scratch" ]]; then 
      workspace=scratch 
    fi 
  fi 

 
 
  if [[ "${win_ids[$k]}" == "$focus_win_id" ]]; then 
    focus="*"
  else 
    focus=" "
  fi   
    
    echo -e "[${workspace}] ${focus} <span weight=\"bold\">${win_types[$k]}</span> - ${win_names[$k]}"
done | rofi -dmenu -markup-rows -i -p window -format i | switch
