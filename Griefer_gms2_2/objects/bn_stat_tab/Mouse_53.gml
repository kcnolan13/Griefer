/// @description all dat ish
if not modal_highlighted(id)
{
    exit_child = true
    exit
}

if clicked exit
    clicked = 5

printf("clicked: "+label)
audio(snd_click,1)

//unhighlight the others
with bn_stat_tab
    active = false
    
//highlight this one
active = true

if stat_manager.stat_tab != stat_tab
{
    wipe_stat_modals()
    stat_manager.stat_tab = stat_tab
    fade_modal(modal_meter)
    fade_modal(bn_slabel)
    fade_modal(modal_stat_history)
    fade_modal(accolade_generic)
}

//global stats request
if stat_tab = stat_manager.tabs[2]
{
    //request global stats
    //sendMessageStr("get_global_stats",FL_NORMAL)
    //now done from stat_manager
}

//competitive stats request
if stat_tab = stat_manager.tabs[0]
{
    //request stats + accolades
    request_personal_stats(stat_manager.grav_name,FL_NORMAL)
    request_accolades(stat_manager.grav_name,FL_NORMAL)
}

//bot stats request
if stat_tab = stat_manager.tabs[1]
{
    //request stats + accolades
    request_personal_stats(stat_manager.grav_name,FL_BOT)
    request_accolades(stat_manager.grav_name,FL_BOT)
}

