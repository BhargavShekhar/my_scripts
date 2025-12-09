#!/bin/bash

FLAG="/tmp/rtc_wake_scheduled"
WAKEFILE="/tmp/autowake_detected"

if [ "$1" = "pre" ]; then
    # PRE = system entering sleep
    # Set a wake timer for 2.5 hours (9000 seconds)
    rtcwake -m no -s 9000

    # Mark that we scheduled a wake
    echo "true" > "$FLAG"
fi

if [ "$1" = "post" ]; then
    # POST = system waking up

    # If flag doesn’t exist, ignore
    if [ ! -f "$FLAG" ]; then
        exit 0
    fi

    # Now detect if this wake was triggered by RTC
    # rtcwake will always set this file on auto wake:
    RTC_STATUS=$(cat /sys/class/rtc/rtc0/wakeup_count 2>/dev/null)

    if [ -f "$WAKEFILE" ]; then
        rm "$FLAG" "$WAKEFILE"
        systemctl poweroff
        exit 0
    fi

    # When system wakes normally (lid opened, button pressed)
    # DO NOT shut down — instead remove timer flag
    rm "$FLAG"
fi
