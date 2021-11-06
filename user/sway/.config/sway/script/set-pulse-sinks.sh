#!/bin/bash

for sink in $(pactl list sinks | grep -E '^Sink #[0-9]*$' | sed 's/[^0-9]*//g'); do
	if [[ "${1,,}" == "raise" ]]; then
		pactl set-sink-volume "$sink" +5%
  elif [[ "${1,,}" == "lower" ]]; then
    pactl set-sink-volume "$sink" -5%
	elif [[ "${1,,}" == "mute" ]]; then
		pactl set-sink-mute "$sink" toggle
	fi
done
