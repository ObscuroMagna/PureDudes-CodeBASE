#!/bin/sh

launchctl stop org.cups.cupsd

#Then rename the the cupsd.conf file:
sudo mv /etc/cups/cupsd.conf /etc/cups/cupsd.conf.backup

#Restore the default cupsd.conf file:
sudo cp /etc/cups/cupsd.conf.default /etc/cups/cupsd.conf

#Then rename the printers.conf file:
sudo mv /etc/cups/printers.conf /etc/cups/printers.conf.backup

#Next, restart cups with:
sudo launchctl start org.cups.cupsd

exit 0  
