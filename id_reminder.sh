#!/bin/bash

zenity --info --title="Countdown Timer" --text="$message" --width=300
zenity --info --title="Countdown Timer" --text="$message" --width=300

# Ensure zenity is installed for the popup
if ! command -v zenity &>/dev/null; then
  echo "Error: 'zenity' is not installed. Install it with: sudo apt install zenity"
  exit 1
fi

while true; do
  # Get current minute and second
  current_min=$(date +%-m)
  current_sec=$(date +%-S)

  # Calculate how many minutes until the next 10-minute interval (0, 10, 20...)
  # We use (10 - (current_min % 10))
  minutes_to_wait=$((10 - (current_min % 10)))

  # Calculate total seconds to sleep
  # Subtract current seconds to align perfectly with the "00" second mark
  seconds_to_sleep=$(((minutes_to_wait * 60) - current_sec))

  # If we are exactly on the 10-minute mark (seconds_to_sleep is 600),
  # but we want to trigger NOW, we handle that here:
  if [ "$seconds_to_sleep" -eq 600 ]; then
    zenity --info --title="Reminder" --text="Time to ID!" --width=200
    # After closing the popup, sleep for the next full 10 mins
    sleep 600
  else
    # Wait until the next interval
    sleep "$seconds_to_sleep"
    zenity --info --title="Reminder" --text="Time to ID!" --width=200
  fi
done
