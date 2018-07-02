/// @description regen post match visuals

//dont regen head if going to get promoted again
if (xp_next - xp) >= 0 and net_manager.menu_mode = "lottery_steal" and room = rm_lobby
    regen_postmatch_visuals()

