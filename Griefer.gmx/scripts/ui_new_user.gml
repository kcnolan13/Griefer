ID = popup_yesno(WVIEW/2,HVIEW/2,
    "Welcome, "+string(objVarRead(net_manager,"pName"))+"!","For "+string(global.xp_tutorial)+" XP and a free helmet, would you like a tour of the Griefer menu?",
    tut_begin,tut_violence)

ID.wait_while_loading = true
ID.post_loading_wait_time = 45
ID.birth_delay = global.tut_bdelay
