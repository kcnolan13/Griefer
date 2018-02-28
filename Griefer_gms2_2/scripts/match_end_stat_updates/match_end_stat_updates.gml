/// @description match_end_stat_updates()
/// @function match_end_stat_updates

printf("::: match end stat updates")

var guy = net_manager.local_player
if not instance_exists(guy)
{
    printf("ERROR: unable to perform match_end_stat_update ... local player does not exist")
    return false
}

var match_kdr = objVarRead(guy,"match_kills") / max(1,objVarRead(guy,"match_deaths"))
match_kdr = truncate(match_kdr,2)
var kdr = (objVarRead(stat_manager,"kills")+objVarRead(guy,"match_kills")) / max(1,objVarRead(stat_manager,"deaths")+objVarRead(guy,"match_deaths"))
kdr = truncate(kdr,2)

var wl = objVarRead(guy,"wins") / max(1,objVarRead(guy,"losses"))
wl = truncate(wl,2)

var match_ppl = objVarRead(guy,"match_points") / max(1,objVarRead(guy,"match_deaths"))
match_ppl = truncate(match_ppl,0)
var ppl = (objVarRead(stat_manager,"points")+objVarRead(guy,"match_points")) / max(1,objVarRead(stat_manager,"deaths")+objVarRead(guy,"match_deaths"))
ppl = truncate(ppl,0)

var wl_spread = objVarRead(stat_manager,"wins")-objVarRead(stat_manager,"losses")

printf("::: Match End Stat Updates")
printf("::: calculated ppl: "+string(ppl)+", guy's points: "+string(objVarRead(guy,"points")))
printf("::: calculated kdr: "+string(kdr)+", calculated wl: "+string(wl))
printf("::: match_kdr = "+string(match_kdr)+", match_ppl = "+string(match_ppl)+", kdr = "+string(kdr)+", ppl = "+string(ppl)+", wl_spread = "+string(wl_spread))

stat_update_real("kdr",kdr,stat_manager.stat_flag)
stat_update_real("wl",wl,stat_manager.stat_flag)
stat_update_real("ppl",ppl,stat_manager.stat_flag)
stat_update_string("kdr_history",string(match_kdr),stat_manager.stat_flag)
stat_update_string("win_history",string(wl_spread),stat_manager.stat_flag)
stat_update_string("ppl_history",string(match_ppl),stat_manager.stat_flag)

with stat_manager
{
    time_match_end = current_time
    time_match_total = time_match_end - time_match_start
}

var time_played = objVarRead(guy,"time")+stat_manager.time_match_total
stat_update_real("time",time_played,FL_NORMAL)
printf("::: updating time: "+string(objVarRead(guy,"time"))+" --> "+string(time_played))

update_kdr = true
update_wl = true
update_ppl = true
