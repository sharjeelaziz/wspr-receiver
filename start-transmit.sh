#!/bin/bash
/usr/local/bin/wspr --repeat "$CALL" "$LOCATOR" 20 20m &>> "$LOGPATH" &
