///draw_notification(num,x,y,scale,color,alpha)
var num = argument0
var dx = argument1
var dy = argument2
var scale = argument3
var color = argument4
var alpha = argument5

scale = scale*global.notification_scale

var rad = 14*scale

//circle fill
draw_set_color(color)
draw_set_alpha(alpha)
draw_circle(dx,dy,rad,false)

//circle outline
draw_set_color(c_white)
draw_circle(dx,dy,rad-1,true)
draw_circle(dx,dy,rad-1/2,true)
draw_circle(dx,dy,rad,true)
draw_circle(dx,dy,rad+1/2,true)
draw_circle(dx,dy,rad+1,true)

//number
draw_set_font(fnt_hud)
draw_set_halign(fa_center)
draw_set_valign(fa_middle)
draw_text_transformed(dx,dy,string(floor(num)),scale,scale,0)