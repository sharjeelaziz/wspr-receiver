#!/bin/bash

# Function to log messages with a timestamp
log_message() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $1" >> "$LOGPATH"
}

# Ensure LOGPATH is set
if [ -z "$LOGPATH" ]; then
    echo "LOGPATH is not set. Exiting."
    exit 1
fi

# Trap signals to ensure cleanup if the script is interrupted
trap 'log_message "Script interrupted."; exit 1' INT TERM

# Kill existing rtlsdr_wsprd processes
if pgrep rtlsdr_wsprd > /dev/null
then
   log_message "---Kill rtlsdr_wsprd processes---"
   pkill rtlsdr_wsprd &>> "$LOGPATH"
   if [ $? -eq 0 ]; then
       log_message "Successfully killed rtlsdr_wsprd."
   else
       log_message "Failed to kill rtlsdr_wsprd."
   fi
   sleep 1
else
   log_message "No rtlsdr_wsprd process found."
fi

# Kill existing wspr processes (transmit)
if pgrep -f /usr/local/bin/wspr > /dev/null
then
   log_message "---Kill wspr processes---"
   pkill -f /usr/local/bin/wspr &>> "$LOGPATH"
   if [ $? -eq 0 ]; then
       log_message "Successfully killed wspr."
   else
       log_message "Failed to kill wspr."
   fi
   sleep 1
else
   log_message "No wspr process found."
fi