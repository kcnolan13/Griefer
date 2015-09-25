ID = popup_yesno(WVIEW/2,HVIEW/2,
    "Violent Content","How do you feel about Strong Cartoon Violence?",
    enable_violence,disable_violence)

ID.is_tutorial = true
ID.critical = true
ID.wait_while_loading = true
ID.post_loading_wait_time = 30
ID.birth_delay = global.tut_bdelay
ID.text_yes = "Sounds Good"
ID.text_no = "Eww, No"
