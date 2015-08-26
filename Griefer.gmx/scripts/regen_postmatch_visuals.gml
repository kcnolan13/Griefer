///regen_postmatch_visuals
if object_index != xp_bar
return false

av = net_manager.my_doll
if not instance_exists(av) or not is_my_avatar(av) return false

xpos = view_xview+view_wview/2
ypos = view_yview
halign = fa_center
valign = fa_top
blah_xoff = -64
av_head_yoff = view_hview*1/5+48

fade_delay = 30*100
birth_delay = 90

myName = objVarRead(net_manager,"pName")
scale = 1.5
twidth = get_head_namerank_width(myName,1.5)

// Avatar Head
av_head = instance_create(xpos-twidth/2,ypos+av_head_yoff,action_word)
av_head.visible = false
av_head.fade_delay = fade_delay
av_head.image = av
av_head.stick_2view = true  
av_head.scale = scale
av_head.init_as_promoted = true
av_head.birth_delay = birth_delay

// Your Name
av_txt = instance_create(xpos+get_head_width(scale)-twidth/2,ypos+av_head_yoff,action_word)
av_txt.visible = false
av_txt.fade_delay = fade_delay
av_txt.stick_2view = true
av_txt.fnt = fnt_hud_big
av_txt.col = c_white
av_txt.txt = capwords(myName)
av_txt.scale = scale
av_txt.init_as_promoted = true
av_txt.halign = fa_left
av_txt.birth_delay = birth_delay

// Rank + Rank Name
av_namerank = instance_create(xpos,ypos+av_head_yoff+112,action_word)
av_namerank.visible = false
av_namerank.fade_delay = fade_delay
av_namerank.stick_2view = true
//av_namerank.drawing_namerank = true
av_namerank.txt = get_rank_name(rank)
av_namerank.vmov = 0
av_namerank.scale = 1.5
av_namerank.init_as_promoted = true
av_namerank.halign = fa_center
av_namerank.birth_delay = birth_delay
