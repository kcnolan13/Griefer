/// @description start match making
if not modal_highlighted(id) exit

if clicked or (net_manager.room_counter < 30*2 and net_manager.previous_room = rm_lobby) exit
clicked = 2

audio(snd_click,1)

net_manager.menu_mode = "play"
// set bot difficulty levels
net_manager.bot_diff_level = bot_diff_level
net_manager.bot_diff_name = label
net_manager.bot_diff_ind = bot_diff_ind

createStartMatchmakingModals()

with bn_choose_difficulty
{
	fade_out = true
}