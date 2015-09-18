///draw_win_popup_centered(x, y, w, h, color, scale, alpha, avatar_object, title, subtitle)
var xdraw = argument0
var ydraw = argument1
var wdraw = argument2
var hdraw = argument3
var color = argument4
var scale = argument5
var alpha = argument6
var av = argument7
var str_title = argument8
var str_subtitle = argument9

var top, left, right, bottom

left = xdraw - wdraw/2*scale
top = ydraw - hdraw/2*scale
right = xdraw + wdraw/2*scale
bottom = ydraw + hdraw/2*scale

draw_set_color(color)
draw_set_alpha(alpha)
draw_rectangle(left, top, right, bottom, false)
draw_set_alpha(1)
draw_set_color(c_white)

if av != noone
    draw_avatar_head(xdraw, ydraw-(ydraw-top)/3, av, 0, scale, 1, FL_NOBAR)
    
draw_set_halign(fa_center)
draw_set_valign(fa_center)
draw_text_ext_transformed(xdraw, ydraw, str_title, 0, right-left, scale, scale, 0)
draw_text_ext_transformed(xdraw, ydraw+(bottom-ydraw)/2, str_subtitle,0, right-left, scale*0.75, scale*0.75, 0)
