ID = popup_yesno(WVIEW/2,HVIEW/2,
    "Control Tips","Would you like to enable Control Tips?",
    enable_tips,disable_tips)

ID.is_tutorial = true
ID.wait_while_loading = true
ID.post_loading_wait_time = 30
ID.birth_delay = global.tut_bdelay
ID.text_yes = "Yes Please"
ID.text_no = "Nope, I Got Dis"
