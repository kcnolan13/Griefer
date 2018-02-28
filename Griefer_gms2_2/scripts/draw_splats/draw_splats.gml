/// @description draw_splats(x,y,scale,color,alpha)
/// @function draw_splats
/// @param x
/// @param y
/// @param scale
/// @param color
/// @param alpha
var draw_x = argument0
var draw_y = argument1
var scale = argument2
var col = argument3
var alpha = argument4

var len = getLength(global.splat_scales)

for (var i=0; i<len; i++)
{
    draw_sprite_ext(spr_splat,global.splat_subs[i],draw_x+scale*global.splat_xoffs[i],draw_y+scale*global.splat_yoffs[i],scale,scale,global.splat_rots[i],col,alpha*global.splat_alphas[i])
}