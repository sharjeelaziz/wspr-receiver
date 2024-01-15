# WSPR receiver on Raspberry PI

WSPR (pronounced "whisper") stands for "Weak Signal Propagation Reporter". It is a protocol, implemented in a computer program, used for weak-signal radio communication between amateur radio operators. The protocol was designed, and a program written initially, by [Joe Taylor, K1JT](https://en.wikipedia.org/wiki/Joseph_Hooton_Taylor_Jr.). Software is now open source and is developed by a small team. The program is designed for sending and receiving low-power transmissions to test propagation paths on the MF and HF bands.

WSPR implements a protocol designed for probing potential propagation paths with low-power transmissions. Transmissions carry a station's callsign, Maidenhead grid locator, and transmitter power in dBm. The program can decode signals with S/N as low as −28 dB in a 2500 Hz bandwidth. Stations with internet access can automatically upload their reception reports to a central database called WSPRnet, which includes a mapping facility.

We will mainly work on the receiving WSPR transmissions here but the Raspberry Pi can also be used as [WSPR beacon](https://tapr.org/?p=5339).

## Install NTPsec
An accurate clock is essential both for transmission, and decoding of received signals. 
 
NTPsec is an excellent option if you want to run a Stratum 1 server on the Raspberry PI. This [HOWTO](https://www.ntpsec.org/white-papers/stratum-1-microserver-howto/) gives complete instructions for building a headless Stratum 1 timeserver using a Raspberry Pi, a GPS HAT, and NTPsec. Total parts cost should be about $110. Beginner-level light soldering may be required.

## Insall rtl-sdr

It seems that the newest kernel includes a DVB driver for the dongle as a TV receiver. We do not require this for our purposed so we will create a config file to blacklist it.

```
$ cd ~
$ sudo apt-get install git git-core cmake build-essential libusb-1.0-0-dev libfftw3-dev curl libcurl4-gnutls-dev

$ cat <<EOF >blacklist-rtl.conf
blacklist dvb_usb_rtl28xxu
blacklist rtl2832
blacklist rtl2830
EOF
$ sudo mv blacklist-rtl.conf /etc/modprobe.d

$ git clone git://git.osmocom.org/rtl-sdr.git
$ cd rtl-sdr
$ mkdir build
$ cd build
$ cmake ../ -DDETACH_KERNEL_DRIVER=ON -DINSTALL_UDEV_RULES=ON
$ make
$ sudo make install
$ sudo ldconfig
$ sudo cp ./rtl-sdr/rtl-sdr.rules /etc/udev/rules.d/
$ sudo reboot
```

Now you should be able to run the ```rtl_test``` command to test as a non-root user. 

## Install rtlsdr-wsprd

Follow instructions to install rtlsdr-wsprd by Guenael (VA2GKA) at https://github.com/Guenael/rtlsdr-wsprd, here are the commands:

```
cd ~
$ git clone https://github.com/Guenael/rtlsdr-wsprd
$ cd rtlsdr-wsprd/
$ sudo make
```

Turn off HDMI to reduce local EMI

```
/opt/vc/bin/tvservice -o
```

You can test rtlsdr_wsprd after replacing your callsign and grid locator values in the following command:

```
$ ./rtlsdr_wsprd -f 14.0956M -c <your-callsign> -l <your-grid-locator> -d 2 -S
``` 

## Multiple band switching with cron jobs

 1. Update and add the information in ```environment.sample``` file to ```/etc/environment```. This makes the environment variable accessible to the scripts executed by cron.
 ```
  CALL="K0DEV"
  GAIN="-a 1"
  LOCATOR="FM18jv"
  WSPR_RECV_PATH="/home/pi/wspr-receiver"
  LOGPATH="$WSPR_RECV_PATH/wsprd-log/wsprd"
  RTLSDR_WSPRD_PATH="/home/pi/rtlsdr-wsprd"
  ```
 2. Add the entries in the ```crontab.sample``` by executing the command ```sudo crontab -e```
 
## References
 - [TAPR WSPR on 20, 30 and 40 Meters](https://tapr.org/?p=5339)
 - [Stratum-1-Microserver HOWTO](https://www.ntpsec.org/white-papers/stratum-1-microserver-howto/)
 - [rtl-sdr](https://osmocom.org/projects/rtl-sdr/wiki)
 - [rtlsdr-wsprd](https://github.com/Guenael/rtlsdr-wsprd)
 - [Tutorial WSPR reception band change with RTLSDR](https://it9ybg.blogspot.com/2018/02/tutorial-wspr-reception-band-change.html)
 
