/// @description draw_bpart_icon_ext(icon, x, y, scale, alpha)
/// @function draw_bpart_icon_ext
/// @param icon
/// @param  x
/// @param  y
/// @param  scale
/// @param  alpha
var icon = argument0
var bpart_x = argument1
var bpart_y = argument2
var scale = argument3
var bpart_alpha = argument4

if not instance_exists(icon)
    drawspr = icon
else
{
    if icon.object_index = bpart_generic or icon.object_index = challenge_generic
    {
        if icon.object_index = challenge_generic
        {
            bpart_alpha = 1
            from = scale
            scale *= scale_2icon(icon.icon)*64/72
            if icon.icon != spr_none and bpart_lookup(icon.icon,global.BPART_LIMB_TYPE) = "prop"
            {
                bpart_x += 8*from/scale*from/scale
                bpart_y += 8*from/scale*from/scale
            }
        }
        drawspr = icon.icon
    }
    else
        drawspr = icon
}
    
var dx = sprite_get_width(drawspr)/2 - sprite_get_xoffset(drawspr)
var dy = sprite_get_height(drawspr)/2 - sprite_get_yoffset(drawspr)

draw_sprite_ext(drawspr,-1,bpart_x-scale*(dx-net_manager.armory_sl/2),bpart_y-scale*(dy-net_manager.armory_sl/2),global.default_scale*scale,global.default_scale*scale,0,c_white,bpart_alpha)