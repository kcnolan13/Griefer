modal_force_click(bn_challenges)

scheduler_queue(tut_armory,global.tut_wait)

ID = popup_okay(WVIEW/2,HVIEW/2,
    "Rewards","Visit this page to redeem completed challenges and equip new items. Griefer is about balance: gear is purely cosmetic.",
    scheduler_run_queue)

ID.is_tutorial = true
ID.wait_while_loading = true
ID.post_loading_wait_time = 45
ID.birth_delay = global.tut_bdelay
ID.text_okay = "Next"
