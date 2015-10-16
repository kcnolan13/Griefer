#!/bin/sh

cd /home/kyle/html/Griefer/GriefNode


case "$(ps -e | grep node | wc -w)" in


0|1|2|3|4|5|6|7|8|9|10|11|12|13|14|15|16|17|18|19|20)
	echo "Restarting Griefer:               $(date)" >> /var/log/griefer
	killall node
	node griefer.js 2>&1 >> /var/log/griefer #sudo gnome-terminal --window-with-profile=GRIEFER -e 'node griefer.js' 
    ;;


*)  
	# all ok
	echo "All Okay:               $(date)" >> /var/log/griefer
    ;;
esac
