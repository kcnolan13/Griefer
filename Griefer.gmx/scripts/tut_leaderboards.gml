with bn_stats
{
    if stat_manager.tabs[2] = stat_tab
    {
        modal_force_click(id)
    }
}

scheduler_queue(tut_bot_stats,global.tut_wait)

ID = popup_okay(WVIEW/2,HVIEW/2,
    "Global Leaderboards","Visit the global leaderboards to find out how you measure up to competition from around the world. Click players to see their personal stats.",
    scheduler_run_queue)

ID.is_tutorial = true
ID.wait_while_loading = true
ID.post_loading_wait_time = 45
ID.birth_delay = global.tut_bdelay
ID.text_okay = "Next"
