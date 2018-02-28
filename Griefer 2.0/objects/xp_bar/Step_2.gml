/// @description disable xp_replay if not in lottery_steal mode
if net_manager.menu_mode != "lottery_steal" and xp_replay and rtime() > 30
{
    xp_replay = false
    xp = objVarRead(net_manager,"xp")
    rank = objVarRead(net_manager,"rank")
    recompute_xp_vars()
}

