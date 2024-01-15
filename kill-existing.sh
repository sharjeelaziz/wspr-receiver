#!/bin/bash

if pgrep rtlsdr_wsprd
then
   echo $'\n'"---Kill rtlsdr_wsprd pid---" >> "$LOGPATH"
   killall rtlsdr_wsprd &>> "$LOGPATH"
   sleep 1
fi

if pgrep -f /usr/local/bin/wspr 
then
   echo $'\n'"---Kill wspr pid---" >> "$LOGPATH"
   pgrep -f /usr/local/bin/wspr | xargs kill &>> "$LOGPATH"
   sleep 1
   fi 

