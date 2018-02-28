/// @description draw_mod_notification(x,y,icon)
/// @function draw_mod_notification
/// @param x
/// @param y
/// @param icon
var dx = argument0
var dy = argument1
var icon = argument2

if bpart_mod_var(icon) = "blood_color"
{
    var col = bpart_mod_val(icon)
    draw_splat_notification(dx,dy,col,1)
}

else if bpart_mod_var(icon) = "animated"
{
    var col = bpart_mod_val(icon)
    draw_icon_animated_notification(dx,dy,col,1)
}
