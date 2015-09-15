modal_force_click(bn_play_tab)

scheduler_queue(tut_get_xp,25)

ID = popup_okay(WVIEW/2,HVIEW/2,
    "That's It!","Get out there and Grief some n00bs . . . #And enjoy the new helmet and "+string(global.xp_tutorial)+" XP  :)",
    scheduler_run_queue)


ID.wait_while_loading = true
ID.post_loading_wait_time = 45
ID.birth_delay = 30
ID.text_okay = "Done"
