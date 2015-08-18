if object_index != xp_bar return false

rank = rank_before_match
xp_replay = true
xp_2earn = xp-xp_before_match

earn_pauser = 30

printf("ERROR: XP_2EARN = "+string(xp_2earn))
printf("ERROR: RANK = "+string(rank))

birth_delay = 30*1.5

mw = instance_create(room_width/2,room_height/2,modal_window)
mw.halign = fa_center
mw.valign = fa_center
mw.width = room_width*1/2-64*2
mw.height = room_height*4/5
mw.depth = -92
mw.alpha_max = 0.6
mw.highlightable = false
mw.color = make_colour_hsv(100,10,80)
mw.birth_delay = birth_delay

aw = instance_create(lottery_x,room_height/2,modal_window)
aw.halign = fa_center
aw.valign = fa_center
aw.width = 64*3
aw.height = room_height*4/5
aw.depth = -92
aw.alpha_max = 0.6
aw.highlightable = false
aw.color = make_colour_hsv(100,10,80)
aw.birth_delay = birth_delay+net_manager.lotto_delay

regen_postmatch_visuals()