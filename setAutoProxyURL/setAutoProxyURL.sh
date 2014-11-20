#!/bin/sh
####################################################################################################
#
# Script to setup Automatic Proxy Configuration on a client.
#
# Adapted from Ben Toms (http://macmule.com):
# GitRepo: https://github.com/macmule/setAutomaticProxyConfigurationURL
# License: http://macmule.com/license/
####################################################################################################

# HARDCODED VALUES ARE SET HERE
autoProxyURL=""

# CHECK TO SEE IF A VALUE WAS PASSED FOR $1, AND IF SO, ASSIGN IT
if [ "$1" != "" ] && [ "$autoProxyURL" == "" ]; then
  autoProxyURL=$1
fi

# Detects all network hardware & creates services for all installed network hardware
/usr/sbin/networksetup -detectnewhardware

# Set IFS so that our for loop breaks on \n instead of spaces
IFS=$'\n'

# Set up a counter so we know how many interfaces we added the Proxy to
changed=0
unchanged=0
errorCount=0

  #Loops through the list of network services
  for i in $(/usr/sbin/networksetup -listallnetworkservices | tail +2);
  do

    # Get a list of all services beginning 'Ether', 'Air', 'VPN', or 'Wi-Fi'
    # If your service names are different to the below, you'll need to change the criteria
    if [[ "$i" =~ 'Ether' ]] || [[ "$i" =~ 'Air' ]] || [[ "$i" =~ 'VPN' ]] || [[ "$i" =~ 'Wi-Fi' ]] ; then
      autoProxyURLLocal=`/usr/sbin/networksetup -getautoproxyurl "$i" | head -1 | cut -c 6-`

      if [[ "$autoProxyURLLocal" == "(null)" ]]; then
        echo "$i Proxy currently empty"
      else
        # Echo's the name of any matching services & the autoproxyURL's set
        echo "$i Proxy set to $autoProxyURLLocal"
      fi

      # If the value returned of $autoProxyURLLocal does not match the value of $autoProxyURL for the interface $i, change it.
      if [[ $autoProxyURLLocal != $autoProxyURL ]]; then
        /usr/sbin/networksetup -setautoproxyurl $i $autoProxyURL
        if [ "$?" == "0" ]; then
          echo "Set proxy for $i to $autoProxyURL"
          changed=`expr $changed + 1`
        else
          echo "ERROR: Proxy could not be set for $i"
          errorCount=`expr $errorCount + 1`
        fi
      else
        echo "Skipped $i (already set properly)"
        unchanged=`expr $unchanged + 1`
      fi
    fi

  done

echo "DONE!"
if [[ "$changed" -gt "0" ]]; then
  echo "Successfully set for proxy for $changed interface(s)."
fi
if [[ "$unchanged" -gt "0" ]]; then
  echo "Proxy already present for $unchanged interface(s)."
fi
if [[ "$errorCount" -gt "0" ]]; then
  echo "Failed to set for proxy for $errorCount interface(s)."
fi

unset IFS
