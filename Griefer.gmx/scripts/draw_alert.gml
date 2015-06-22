///draw_alert(x,y,title,subtitle,body,color)
var xdraw = argument0
var ydraw = argument1
var titl = argument2
var sub = argument3
var body = argument4
var col = argument5

draw_set_alpha(global.player_popup_alpha)
draw_popup(xdraw, ydraw, titl, sub, "", body, col, 1)
draw_set_alpha(1)