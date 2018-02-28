/// @description inherit and define properties
event_inherited()
text = ""
text_halign = fa_left
alpha_max = 0.75
halign = fa_center
valign = fa_center
life = 0

width = __view_get( e__VW.WView, 0 )*2/3+64
height = __view_get( e__VW.HView, 0 )*2/3
extra_height = 50

if in_match()
{
    draw_gradient = true
    draw_fade = true
    omit_internal_gradient = true
    
    mode_index = 0
    __view_set( e__VW.WView, 0, 1365 )
    __view_set( e__VW.HView, 0, 9/16*1365 )
}
else
{
    mode_index = 1
}   

x = __view_get( e__VW.XView, 0 )+__view_get( e__VW.WView, 0 )/2
y = __view_get( e__VW.YView, 0 )+__view_get( e__VW.HView, 0 )/2+36

if not in_match()
{
    height -= 24
    y -= 13
}

behave_match = in_match()

y_adder = 22
x_adder_menus = 0//64*1.5

x_adder = 0

y += y_adder
x += x_adder

x_adder += 64*2+84-44+25
y_adder += 64*1.5-56+18

snap_2view = true

highlightable = false

alarm[0] = 10

exit_child = false

hue = 0
sat = 0
val = 20
alpha_max = 0.75
notif_scale = 1.25

main_hue = 238

chue = main_hue
csat = 0
cval = 0
chue_mult = 1
csat_mult = 0.75
cval_mult = 4

header_height = 72
header_xoff = 24
header_yoff = -14
header_font = fnt_menu
header_color = c_black//web_hsv(main_hue,csat*2,65)
header_orig = "Control Settings: "

color = web_hsv(main_hue,csat,cval*0.5)

gamepad_yes = "Gamepad Detected"
gamepad_no = "[No Gamepad Detected]"

header_text_color = c_white
text_color = c_white

header_texts[0] = "Match Settings"
header_texts[1] = "General Options"
header_texts[2] = ""
modes[0] = "Match Settings"
modes[1] = "General Options"
modes[2] = "Controls"

if in_match()
{
    draw_fade = true
    fade_alpha = 0.8
    fade_color = c_black
}

header_text = header_texts[1]
mode = modes[mode_index]

