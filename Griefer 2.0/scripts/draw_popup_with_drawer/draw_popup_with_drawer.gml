/// @description draw_popup_with_drawer(x, y, title, subtitle, source, body_text_override, color, alpha, icon_ref)
/// @function draw_popup_with_drawer
/// @param x
/// @param  y
/// @param  title
/// @param  subtitle
/// @param  source
/// @param  body_text_override
/// @param  color
/// @param  alpha
/// @param  icon_ref
popup_drawn = true
var draw_x = argument0
var draw_y = argument1
var dat_title = argument2
var subtitle = argument3
var source = argument4
var body_text_override = argument5
var color = argument6
var alpha = argument7
var icon_ref = argument8

popup_drawer.icon_ref = icon_ref

if draw_x = mouse_x and draw_y = mouse_y and global.using_gamepad
{
    draw_x = cursor.x
    draw_y = cursor.y
}

alpha = average3(alpha,1,1)

popup_drawer.draw_x = draw_x; popup_drawer.draw_y = draw_y; popup_drawer.dat_title = dat_title;
popup_drawer.subtitle = subtitle;
popup_drawer.source = source; popup_drawer.body_text_override = body_text_override; popup_drawer.color = color;
popup_drawer.draw_it = true
popup_drawer.alpha = alpha