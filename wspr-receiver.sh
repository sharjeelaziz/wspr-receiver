#!/bin/bash

# Default values if not provided as arguments
DEFAULT_FREQUENCY="14.0956M"
DEFAULT_BAND="20 meters"

# Use the provided arguments or fall back to the defaults
FREQUENCY="${1:-$DEFAULT_FREQUENCY}"
BAND="${2:-$DEFAULT_BAND}"
INFO_RX="Starting reception on $BAND with frequency $FREQUENCY"

echo -e "\n$(date)" >> "$LOGPATH"
echo "$INFO_RX" >> "$LOGPATH"
sleep 1

"${RTLSDR_WSPRD_PATH}/rtlsdr_wsprd" -f "$FREQUENCY" -c "$CALL" -l "$LOCATOR" -d 2 &>> "$LOGPATH" &

