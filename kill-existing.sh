#!/bin/bash

if pgrep rtlsdr_wsprd
then
   echo $'\n'"---Kill rtlsdr_wsprd pid---" >> "$LOGPATH"
   killall rtlsdr_wsprd &>> "$LOGPATH"
   sleep 1
fi

if pgrep wspr
then
   echo $'\n'"---Kill wspr pid---" >> "$LOGPATH"
   killall wspr &>> "$LOGPATH"
   sleep 1
fi