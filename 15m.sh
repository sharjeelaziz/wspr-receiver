#!/bin/bash

FREQUENCY="21.0946M"
INFO_RX="Starting reception on 15 meters"

echo $'\n'"$(date)" >> "$LOGPATH"
echo "$INFO_RX"$'\n' >> "$LOGPATH"
sleep 1

"$RTLSDR_WSPRD_PATH"/rtlsdr_wsprd -f "$FREQUENCY" -c "$CALL" -l "$LOCATOR" "$GAIN" -d 2 &>> "$LOGPATH" &
