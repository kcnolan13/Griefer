///draw_mod_notification(x,y,icon)
var dx = argument0
var dy = argument1
var icon = argument2

if bpart_mod_var(icon) = "blood_color"
{
    var col = bpart_mod_val(icon)
    draw_splat_notification(dx,dy,col,1)
}
