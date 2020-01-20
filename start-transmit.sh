#!/bin/bash
wspr --repeat "$CALL" "$LOCATOR" 20 20m &>> "$LOGPATH" &