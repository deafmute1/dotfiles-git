#!/bin/bash

for source in $(pactl list sources | grep -E '^Source #[0-9]*$' | sed 's/[^0-9]*//g'); do
	pactl set-source-mute "$source" toggle
done
