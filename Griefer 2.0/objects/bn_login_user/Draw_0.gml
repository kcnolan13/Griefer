/// @description draw code
draw_set_color(make_color_rgb(60,60,60))
hoff = sprite_get_width(spr_input_field)
voff = 64*3
left = field_username.bbox_left-32
top = field_username.bbox_top-48
right = field_username.bbox_right+32
bottom = field_password.bbox_bottom+74

draw_set_alpha(1)
draw_rectangle(left,top,right,bottom,false)
draw_set_color(make_color_rgb(45,45,45))
draw_rectangle(left,bottom-48,right,bottom,false)
draw_set_color(make_color_rgb(20,20,20))
draw_rectangle(left,bottom-8,right,bottom,false)
draw_set_color(c_white)

if alert_alpha > 0
{
    //draw alerts
    draw_set_font(fnt_hud)
    draw_set_alpha(alert_alpha)
    draw_set_color(make_color_rgb(150,0,0))
    draw_rectangle(left,top-48,right,top-16,false)
    draw_set_color(c_red)
    draw_rectangle(left,top-48,right,top-48+4,false)
    draw_set_halign(fa_center)
    draw_set_valign(fa_center)
    draw_set_color(c_white)
    draw_text((right+left)/2,top-32, string_hash_to_newline(alert))
    draw_set_alpha(1)
}


if room = rm_login
{
/*  shadow_scale = 0.25+0.0035*(y-ystart)
    draw_sprite_ext(spr_doll_shadow,0,room_width/2,room_height-2*64,2*shadow_scale,shadow_scale,0,c_white,0.8)
*/}

event_inherited()

/* */
/*  */
