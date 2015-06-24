///draw_splat_notification(x,y,color,alpha)

var dx = argument0
var dy = argument1
var col = argument2
var alpha = argument3

var scale = 0.15*global.notification_scale

if object_index = challenge_generic
    scale *= txt_scale

draw_splats(dx,dy+global.moffset,scale,col,1)

