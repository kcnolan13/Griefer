#!/bin/sh

cd /home/kyle/html/Griefer/GriefNode

case "$(pidof node | wc -w)" in

0|1)  echo "Restarting Griefer:     $(date)" >> /var/log/griefer.txt
    node griefer.js 2>&1 >> /var/log/griefer.log #sudo gnome-terminal --window-with-profile=GRIEFER -e 'node griefer.js' 
    node keepup.js 2>&1 >> /var/log/keepup.log
    ;;
2)  # all ok
	echo "All Okay:               $(date)" >> /var/log/griefer.txt
    ;;
*)  echo "Too Many Nodes:         $(date)" >> /var/log/griefer.txt
    ;;
esac
