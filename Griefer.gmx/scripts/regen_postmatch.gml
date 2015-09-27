if object_index != xp_bar return false

rank = rank_before_match
xp_replay = true
xp_2earn = xp-xp_before_match

earn_pauser = 30

printf("ERROR: XP_2EARN = "+string(xp_2earn))
printf("ERROR: RANK = "+string(rank))

birth_delay = 20

mw = instance_create(room_width/2,room_height/2,modal_window)
mw.halign = fa_center
mw.valign = fa_center
mw.width = room_width*1/2-64*2
mw.height = room_height*4/5
mw.depth = -92
mw.alpha_max = 0.5
mw.highlightable = false
mw.color = c_black//make_colour_hsv(100,10,80)
mw.birth_delay = birth_delay
mw.menu_mode = "lottery_steal"
mw.pop_sound = snd_pan1
mw.pop_gain = GAIN_PAN

aw = instance_create(lottery_x,room_height/2,modal_window)
aw.halign = fa_center
aw.valign = fa_center
aw.width = 64*3
aw.height = room_height*4/5
aw.depth = -92
aw.alpha_max = 0.5
aw.highlightable = false
aw.color = c_black//make_colour_hsv(100,10,80)
aw.birth_delay = birth_delay+net_manager.lotto_delay
aw.menu_mode = "lottery_steal"
aw.pop_sound = snd_pan1
aw.pop_gain = GAIN_PAN

done_spacer = 32
accw = instance_create(room_width*1/6+64,room_height*1/4-32+64*1.75+32,modal_window)
accw.halign = fa_center
accw.valign = fa_center
accw.width = 64*3
accw.height = mw.height - 64*1.75 - done_spacer
accw.depth = -92
accw.alpha_max = 0.5
accw.highlightable = false
accw.color = c_black//make_colour_hsv(100,10,80)
accw.birth_delay = birth_delay+30
accw.menu_mode = "lottery_steal"
accw.header_text = "Top "+global.accolade_name+"s"
accw.header_height = 36
accw.header_alpha = 0
accw.pop_sound = snd_pan1
accw.pop_gain = GAIN_PAN

if instance_exists(mw)
{
    accw.y = mw.y-mw.height/2+64*1.75+done_spacer+accw.height/2
}

regen_postmatch_visuals()
