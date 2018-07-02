event_inherited()

if exit_child or net_manager.lobby_match_countdown
{
    exit_child = false
    exit
}

if label = txt_logout or room = rm_menu
{
    if net_manager.armor_modified = false and not net_manager.saving_armor
    {
        if objVarRead(net_manager,"game_mode") != "no_mode"
        {
            leave_matchmaking()
            sendMessageReal("syncPlayersConnected",FL_NORMAL)
        }
        logOut()
        griefer_restart()
    } else {
        if not net_manager.saving_armor
            net_manager.saving_armor = net_manager.saving_armor_max
            
        net_manager.saving_armor_reboot = true
        
        with net_manager send_all_bpart_stats()
    }
} else
{
    net_manager.party_leader = false
    net_manager.in_party = false
    net_manager.bot_match = false
    leave_matchmaking()
    sendMessageReal("syncPlayersConnected",FL_NORMAL)
}

