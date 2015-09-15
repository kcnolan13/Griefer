with modal_button
{
    blocked = true
}

scheduler_queue(tut_options,global.tut_wait)

ID = popup_okay(WVIEW/2,HVIEW/2,
    "Main Menu","From here, you can play competitively in "+global.cmode+", or practice your skills in "+global.bmode,
    scheduler_run_queue)

ID.is_tutorial = true
ID.wait_while_loading = true
ID.post_loading_wait_time = 45
ID.birth_delay = global.tut_bdelay
ID.text_okay = "Next"
