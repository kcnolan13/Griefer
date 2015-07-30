///leave_matchmaking()
leaveMatchMaking()
net_manager.lock_armory = false
objVarWrite(net_manager,"game_mode","no_mode")
if room != rm_menu
{
    room_goto(rm_menu)
}