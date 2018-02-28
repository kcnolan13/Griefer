/// @description inherit and define properties
event_inherited()

master_scale = 1
match_scale = 0.9

is_gui = true

force_show = false
width = 64*6+52
height = 64*4.5
entry_height = 48
entry_width = width
send_width = 64*1.5
//TEXT ENTRY
entry = instance_create(x,y,input_field)
entry.persistent = true
entry.image_yscale = (entry_height/sprite_get_height(entry.sprite_index))
entry.image_xscale = (entry_width-send_width)/sprite_get_width(entry.sprite_index)
entry.label = ""
entry.font = fnt_feed
entry.max_length = 80
entry.depth = depth-2
//SEND BUTTON
send = instance_create(x,y,modal_button)
send.width = send_width
send.height = entry_height
send.halign = fa_center
send.valign = fa_center
send.text_halign = fa_center
send.text_valign = fa_center
send.font = fnt_hud_big
send.text_color = c_white
send.color = web_hsv(0,0,10)
send.color_highlighted = web_hsv(226,50,70)
send.snap_2view = false //snapping will be done right from chat feed
send.persistent = true
send.text = "SEND"
send.scale_highlighted = 1
send.text_alpha_override = false
send.depth = depth-2
send.is_gui = true

text = ""
text_halign = fa_left
alpha_max = 0.5
alpha_max_original = alpha_max
halign = fa_center
valign = fa_center

alpha_scaler_max = 1
alpha_scaler = alpha_scaler_max
alpha_dec = 0.025
alpha_dec_delay = 0
alpha_dec_delay_max = 30*2

snap_2view = false //does its own

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
header_height = 38
header_xoff = 0
header_yoff = -4
header_font = fnt_hud_big
header_color = c_black//web_hsv(main_hue,csat*2,65)
color = web_hsv(main_hue,csat,cval*0.5)
header_text_color = c_white
text_color = c_white
header_text = "Lobby Chat"

x = width/2
y = HVIEW-height/2-entry_height
modal_aligns()

snap_2view = false
highlightable = false
exit_child = false

//THE MESSAGES
msgs = 0
msgs_max = 4
msg_ysep = 28
msg_height = (height-header_height-msg_ysep*msgs_max)/msgs_max
msg_starty = height-msg_height/2-5
msg_width = width
msg_avhead_scale = (msg_height)/82
msg_text_width = msg_width - msg_avhead_scale*2*160


