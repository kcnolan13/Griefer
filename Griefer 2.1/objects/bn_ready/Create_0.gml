/// @description inherit and define properties
event_inherited()
alpha = 0
alpha_max = 0
alpha_highlight = 0
halign = fa_center
valign = fa_center
font = fnt_hud
bound_avatar = NO_HANDLE
snap_2view = false
sent_ready = false

highlightable = true

ready = false
ready_text = "Ready"
not_ready_text = "Not Ready"
text_color_ready = c_black//web_hsv(150,100,75)
text_color_not_ready = c_dkgray//web_hsv(0,60,75)

width = 64*5
height = 64

if ready 
    text = ready_text 
else text = not_ready_text

ready_font = fnt_ready
not_ready_font = fnt_not_ready

alarm[0] = 1

exit_child = false

hue = 0
sat = 0
val = 0
notif_scale = 1.25

visible = false

