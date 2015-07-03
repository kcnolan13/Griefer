///match_end_stat_updates()

var guy = net_manager.local_player
if not instance_exists(guy)
{
    printf("ERROR: unable to perform match_end_stat_update ... local player does not exist")
    return false
}


var kdr = objVarRead(guy,"kills") / max(1,objVarRead(guy,"deaths"))
kdr = truncate(real(kdr),2)

var wl = objVarRead(net_manager,"wins") / max(1,objVarRead(net_manager,"losses"))
wl = truncate(real(wl),2)

var ppl = objVarRead(guy,"points") / max(1,objVarRead(guy,"deaths"))
ppl = truncate(real(ppl),2)

printf("::: calculated ppl: "+string(ppl)+", guy's points: "+string(objVarRead(guy,"points")))

stat_update_real("kdr",kdr,stat_manager.stat_flag)
stat_update_real("wl",wl,stat_manager.stat_flag)
stat_update_real("ppl",ppl,stat_manager.stat_flag)
stat_update_string("kdr_history",string(kdr),stat_manager.stat_flag)
stat_update_string("win_history",string(wl),stat_manager.stat_flag)
stat_update_string("ppl_history",string(ppl),stat_manager.stat_flag)

update_kdr = true
update_wl = true
update_ppl = true
