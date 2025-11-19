#!/usr/bin/env bash

# Start cool-retro-term running cmatrix
cool-retro-term --fullscreen -e bash -c "sh ~/cmatrix.sh" &
CRT_PID=$!

# Wait for either:
# - 300 seconds (idle period)
# - OR the retro-term to exit (user came back)

SECONDS=0
while kill -0 "$CRT_PID" 2>/dev/null; do
    sleep 1
    if [ "$SECONDS" -ge 300 ]; then
        break
    fi
done

# If user interrupted before 5 minutes → exit without locking
if ! kill -0 "$CRT_PID" 2>/dev/null; then
    # User returned, stop script silently
    exit 0
fi

# Otherwise, time expired → lock screen
pkill -TERM -P "$CRT_PID" 2>/dev/null
pkill cool-retro-term 2>/dev/null
betterlockscreen -l dimblur
