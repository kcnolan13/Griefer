///download_new_game()
url_open("http://www.puddlesquid.com/griefer/release/Griefer.exe")

alert = popup_alert(WVIEW/2,HVIEW/2,"Downloading...","You'll be back in the action before you know it!")
alert.header_text_color = c_white
alert.header_color = web_hsv(218,50,75)
alert.game_end_on_destroy = true
