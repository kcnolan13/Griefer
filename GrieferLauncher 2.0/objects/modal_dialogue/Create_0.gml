/// @description inherit and define properties
life = 0
event_inherited()

scale_die = 0.5

loading_counter = 0
loading_counter_max = 4
loading_counter_inc = 0.1

load_rot = 0
load_rot_inc = 20
load_closable = true
load_life_max = 0

width = 64*2.25*2.5
height = 64*1.5*2.5

header_text_color = c_white
header_font = fnt_hud_medium
font = fnt_hud

active = false
highlightable = true

alpha_max = 1
scale_normal = 1.25
scale_highlighted = 1.025*scale_normal
halign = fa_center
valign = fa_center

text_valign = fa_top
text_halign = fa_center
text_yoff = 96

snap_2view = true

alarm[0] = 1

exit_child = false

parent_dialogue = noone

is_yesno = false
is_alert = false
is_loading = false
is_input_field = false
is_password = false
is_tutorial = false
is_ui_countdown = false
is_downloading = false
is_checking = false
is_launching = false

bn_yes = noone
bn_no = noone
bn_okay = noone
bn_input = noone

scr_yes = scr_none
scr_no = scr_none
scr_okay = scr_none

draw_fade = true
draw_gradient = true
fade_color = c_black
fade_alpha = 0.65

is_gui = true
scale_lerp_real = 0.4

color = web_hsv(0,0,5)

depth = -99999999

critical = false

text_yes = "Yes"
text_no = "No"
text_okay = "Okay"
text_downloading = "Downloading Updates"
text_launching = "Launching the Game"
text_checking = "Checking for Updates"

