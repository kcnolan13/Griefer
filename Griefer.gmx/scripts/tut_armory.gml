modal_force_click(bn_armory)

scheduler_queue(tut_end,global.tut_wait)

ID = popup_okay(WVIEW/2,HVIEW/2,
    "Armory","As you earn and redeem gear and props, this is where you go to equip it and swag up your avatar.",
    scheduler_run_queue)

ID.is_tutorial = true
ID.wait_while_loading = true
ID.post_loading_wait_time = 45
ID.birth_delay = global.tut_bdelay
ID.text_okay = "Next"
