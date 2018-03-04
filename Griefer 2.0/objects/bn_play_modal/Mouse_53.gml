/// @description make new modals
if not modal_highlighted(id) exit

var left = net_manager.play_left-width/2
var top = net_manager.play_top+24

if text = global.pmode
{
    //start a party
    net_manager.party_leader = true
    net_manager.in_party = true
}

audio(snd_click,1)

net_manager.menu_mode = "play"

if not play_bots
{
	createStartMatchmakingModals()
} else {
	createChooseDifficultyModals()
}

with bn_play_modal 
{
    fade_out = true
}

