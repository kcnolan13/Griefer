with bn_stats
{
    if stat_manager.tabs[1] = stat_tab
    {
        modal_force_click(id)
    }
}

scheduler_queue(tut_stats,global.tut_wait)

ID = popup_okay(WVIEW/2,HVIEW/2,
    "Bot Stats","These statistics measure your skill against computer-controlled characters. The more you level up, the harder they fight!",
    scheduler_run_queue)

ID.is_tutorial = true
ID.wait_while_loading = true
ID.post_loading_wait_time = 45
ID.birth_delay = global.tut_bdelay
ID.text_okay = "Next"
