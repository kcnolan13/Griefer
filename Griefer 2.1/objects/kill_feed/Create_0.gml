/// @description inherit and define properties
event_inherited()
text = ""
text_halign = fa_left
alpha_max = 0.5
alpha_max_original = alpha_max
halign = fa_center
valign = fa_center

is_gui = true

master_scale = 1.5
match_scale = 0.9

alpha_scaler_max = 1
alpha_scaler = alpha_scaler_max
alpha_dec = 0.025
alpha_dec_delay = 0
alpha_dec_delay_max = 30*2

snap_2view = false //does its own

width = 64*3.75
height = 64*4

hue = 0
sat = 0
val = 20
notif_scale = 1.25
main_hue = 238
chue = main_hue
csat = 0
cval = 10
chue_mult = 1
csat_mult = 0.75
cval_mult = 4
header_height = 28
header_xoff = 0
header_yoff = -8
header_font = fnt_hud_big
header_color = c_black//web_hsv(main_hue,csat*2,65)
color = web_hsv(main_hue,csat,cval*0.5)
header_text_color = c_white
text_color = c_white
header_text = "Kill Feed"

snap_2view = true
highlightable = false
exit_child = false

x = width/2
y = HVIEW-height/2
modal_aligns()

//THE MESSAGES
msgs = 0
msgs_max = 4
msg_ysep = 28
msg_height = (height-header_height-msg_ysep*msgs_max)/msgs_max
msg_starty = header_height+msg_height/2+msg_ysep
msg_width = width
msg_avhead_scale = (msg_height)/82
msg_text_width = msg_width - msg_avhead_scale*2*120


