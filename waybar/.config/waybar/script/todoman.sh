#!/usr/bin/env bash
# required todoman and jq

set -Eeu -o pipefail

BUTTON="${button:-}"

# get font and icon specifics from xresource file
VALUE_FONT=${font:-$(xrescat i3xrocks.value.font "JetBrains Mono Medium 13")}
VALUE_COLOR=${color:-$(xrescat i3xrocks.value.color "#D8DEE9")}
LABEL_COLOR=${label_color:-$(xrescat i3xrocks.label.color "#7B8394")}
LABEL_ICON=${label_icon:-$(xrescat i3xrocks.label.todo "  ")}

COUNT=$(todoman --porcelain list --status "IN-PROCESS,NEEDS-ACTION" | jq length)

# output number of uncompleted tasks using pango markup
ICON_SPAN="<span color=\"${LABEL_COLOR}\">$LABEL_ICON</span>"
VALUE_SPAN="<span font_desc=\"${VALUE_FONT}\" color=\"${VALUE_COLOR}\">${COUNT}</span>"

echo "${ICON_SPAN}${VALUE_SPAN}"

# make the blocklet clickable
if [ "x${BUTTON}" == "x1" ]; then
    /usr/bin/i3-msg -q exec "/usr/bin/kitty --class=floating_window sh -c 'todoman list && todoman shell'"
fi
