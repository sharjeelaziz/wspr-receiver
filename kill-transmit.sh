#!/bin/bash

if pgrep -f /usr/local/bin/wspr 
then
   echo $'\n'"---Kill wspr pid---" >> "$LOGPATH"
   pgrep -f /usr/local/bin/wspr | xargs kill &>> "$LOGPATH"
   sleep 1
   fi
