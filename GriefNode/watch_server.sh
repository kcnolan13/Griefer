#!/bin/sh
gnome-terminal --window-with-profile=GRIEFER -e 'watch -n0.2 tail -50 /home/kyle/www/html/Griefer/GriefNode/log/matchmaking.log'
gnome-terminal --window-with-profile=GRIEFER -e 'watch -n0.2 tail -50 /home/kyle/www/html/Griefer/GriefNode/log/sql.log'
gnome-terminal --window-with-profile=GRIEFER -e 'watch -n0.2 tail -50 /home/kyle/www/html/Griefer/GriefNode/log/critical.log'
gnome-terminal --window-with-profile=GRIEFER -e 'watch -n0.2 tail -50 /home/kyle/www/html/Griefer/GriefNode/log/general.log'
gnome-terminal --window-with-profile=GRIEFER -e 'watch -n0.2 tail -50 /home/kyle/www/html/Griefer/GriefNode/log/sockets.log'