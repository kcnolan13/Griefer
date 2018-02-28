event_inherited()

if exit_child
{
    exit_child = false
    exit
}

if active = false and not net_manager.lock_armory
{
    active = true
    
    popup_loading(WVIEW/2,HVIEW/2)

    if menmode() != "stats"
    {
        stat_manager.stat_tab = stat_tab
        
        if instance_exists(net_manager.stat_gravatar)
            gravatar_wipe(net_manager.stat_gravatar)
            
        var fl = FL_NORMAL
        if stat_tab = stat_manager.tabs[1]
            fl = FL_BOT
            
        stat_manager.update_kdr = true
        stat_manager.update_wl = true
        stat_manager.update_ppl = true
        stat_manager.update_flag = fl
        stat_manager.grav_ready = false
        stat_manager.grav_name = objVarRead(net_manager,"pName")
        request_personal_stats(stat_manager.grav_name,fl)
        request_accolades(stat_manager.grav_name,fl)
        net_manager.menu_mode = "stats"
    }
    else if stat_manager.stat_tab != stat_tab
    {
        wipe_stat_modals()
        stat_manager.stat_tab = stat_tab
        fade_modal(modal_meter)
        fade_modal(bn_slabel)
        fade_modal(modal_stat_history)
        
        with accolade_generic instance_destroy()
        
        with accolade_manager
        {
            //fade_modal(bg)
            //fade_modal(chev_left)
            //fade_modal(chev_right)
            
            with bg instance_destroy()
            with chev_left instance_destroy()
            with chev_right instance_destroy()
            
            spawned_grid = false
        }
        
        if stat_tab = stat_manager.tabs[2]
        {
            //do nothing
        }
        else if stat_tab = stat_manager.tabs[0]
        {
            //request stats + accolades
            request_accolades(stat_manager.grav_name,FL_NORMAL)
            request_personal_stats(stat_manager.grav_name,FL_NORMAL)
        }
        else if stat_tab = stat_manager.tabs[1]
        {
            //request stats + accolades
            request_accolades(stat_manager.grav_name,FL_BOT)
            request_personal_stats(stat_manager.grav_name,FL_BOT)
        }
    }
}
else {
    active = false
}

