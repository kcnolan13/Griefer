///player_quit_stat_updates(player_obj)
var guy = argument0
var pname = objVarRead(guy,"pName")

printf("::: Penalizing "+pname+" for quitting")
pname_stat_update_real(pname, "losses", 1, FL_INCREMENT)
objVarAdd(pname,"losses",1)

//do his match end stat updates for him ... Muahahahaha!
printf("::: Updating "+genVal+"'s match history..... Muahahahaha!")

if not instance_exists(guy)
{
    printf("ERROR: unable to perform player_quit_stat_updates ... "+string(guy)+" does not exist")
    return false
}

var wl_spread = objVarRead(guy,"wins")-objVarRead(guy,"losses")

var match_kdr = objVarRead(guy,"match_kills") / max(1,objVarRead(guy,"match_deaths"))
match_kdr = truncate(match_kdr,2)

var match_ppl = objVarRead(guy,"match_points") / max(1,objVarRead(guy,"match_deaths"))
match_ppl = truncate(match_ppl,0)

printf("::: match_kdr = "+string(match_kdr)+", match_ppl = "+string(match_ppl))

pname_stat_update_string(pname,"kdr_history",string(match_kdr),stat_manager.stat_flag)
pname_stat_update_string(pname,"win_history",string(wl_spread),stat_manager.stat_flag)
pname_stat_update_string(pname,"ppl_history",string(match_ppl),stat_manager.stat_flag)

with stat_manager
{
    time_match_end = current_time
    time_match_total = time_match_end - time_match_start
}

pname_stat_update_real(pname,"time",current_time-stat_manager.time_match_start,FL_INCREMENT)
printf("::: adding time: "+string(current_time-stat_manager.time_match_start))

printf("::: Successfully Penalized "+pname+"!")
