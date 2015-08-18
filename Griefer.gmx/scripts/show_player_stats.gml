///show_player_stats(pName)
var pname = argument0

audio(snd_click,1)
//show his stats!
net_manager.menu_mode = "stats"
//request personal stats
stat_manager.stat_tab = stat_manager.tabs[0]
var fl = FL_NORMAL
gravatar_wipe(net_manager.stat_gravatar)
stat_manager.grav_ready = false
stat_manager.grav_name = pname
printf("::: requesting gravatar stats for "+string(stat_manager.grav_name))
request_personal_stats(stat_manager.grav_name,fl)
request_accolades(stat_manager.grav_name,fl)

if stat_manager.grav_name = objVarRead(myAvatar(),"pName")
{
    stat_manager.update_kdr = true
    stat_manager.update_wl = true
    stat_manager.update_ppl = true
    stat_manager.update_flag = fl
}

with bn_stat_tab
{
    if stat_manager.stat_tab = stat_tab
        active = true
    else
        active = false
}
