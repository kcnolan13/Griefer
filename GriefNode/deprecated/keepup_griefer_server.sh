#!/bin/sh

cd /home/kyle/www/html/Griefer/GriefNode

case "$(pidof node | wc -w)" in

0)  echo "Restarting Griefer:     $(date)" >> /var/log/griefer.txt
    node griefer.js 2>&1 >> /var/log/griefer_server.txt #sudo gnome-terminal --window-with-profile=GRIEFER -e 'node griefer.js' 
    ;;
1)  # all ok
	echo "All Okay:               $(date)" >> /var/log/griefer.txt
    ;;
*)  echo "Multiple Nodes:         $(date)" >> /var/log/griefer.txt
    ;;
esac
