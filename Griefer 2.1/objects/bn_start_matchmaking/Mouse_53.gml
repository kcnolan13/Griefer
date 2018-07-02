/// @description start match making
if not modal_highlighted(id) exit

if clicked or (net_manager.room_counter < 30*2 and net_manager.previous_room = rm_lobby) exit
clicked = 2

audio(snd_click,1)

if label = "Back"
{
    net_manager.party_leader = false
    net_manager.in_party = false
    net_manager.bot_match = false
    with bn_start_matchmaking {fade_out = true}
    leave_matchmaking()
    sendMessageReal("syncPlayersConnected",FL_NORMAL)
    return false
}

if not net_manager.party_leader or not net_manager.in_party
{
    if objVarRead(net_manager,"game_mode") = "no_mode"
    {
        start_matchmaking(label)
    }
    else
    {
        leave_matchmaking()
        start_matchmaking(label)
    }
}
else
{
    sendBigMessageStr("start_party",label,"","")
}

sendMessageReal("syncPlayersConnected",FL_NORMAL)

