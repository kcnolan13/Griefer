modal_force_click(bn_settings)

scheduler_queue(tut_leaderboards,global.tut_wait)

ID = popup_okay(WVIEW/2,HVIEW/2,
    "Options","The options screen lets you create custom control mappings, connect a gamepad, and adjust the look and feel of the game.",
    scheduler_run_queue)

ID.is_tutorial = true
ID.wait_while_loading = true
ID.post_loading_wait_time = 45
ID.birth_delay = global.tut_bdelay
ID.text_okay = "Next"
