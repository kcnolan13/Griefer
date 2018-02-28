with bn_stats
{
    if stat_manager.tabs[0] = stat_tab
    {
        modal_force_click(id)
    }
}

scheduler_queue(tut_rewards,global.tut_wait)

ID = popup_okay(WVIEW/2,HVIEW/2,
    "Stats","Go here to check out your competitive stats. View other players' stats by clicking on their avatars.",
    scheduler_run_queue)

ID.is_tutorial = true
ID.wait_while_loading = true
ID.post_loading_wait_time = 45
ID.birth_delay = global.tut_bdelay
ID.text_okay = "Next"
