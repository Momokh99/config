#!/bin/bash

WALL_DIR="$HOME/Pictures/hypr_walls"
WALLS=("$WALL_DIR"/*)
STATE_FILE="$HOME/.cache/hypr_wall_index"

# Get current index or initialize
if [[ -f "$STATE_FILE" ]]; then
    current_idx=$(<"$STATE_FILE")
else
    current_idx=0
fi

# Calculate next index (0,1,2 cycle)
next_idx=$(( (current_idx + 1) % 3 ))

# Set new wallpaper
hyprctl hyprpaper wallpaper ",${WALLS[$next_idx]}"

# Update state
echo $next_idx > "$STATE_FILE"
