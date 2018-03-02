draw_set_alpha(alpha)

if input_active = true or instance_place(x+__view_get( e__VW.XView, 0 ),y+__view_get( e__VW.YView, 0 ),cursor)
    image_index = 1
else
    image_index = 0

draw_set_font(font)
var fnt_scale = 1
if font = fnt_feed
    fnt_scale = 0.5

draw_sprite_ext(sprite_index,image_index,x,y,image_xscale*master_scale,image_yscale*master_scale,0,image_blend,alpha)
draw_set_halign(fa_left)
draw_set_valign(fa_center)

draw_set_color(c_white)
if not is_password
	draw_string = input_string
else {
	draw_string = ""
	for (i=1; i<string_length(input_string); i++) {
		draw_string += "*"
	}
	draw_string += string_char_at(input_string,string_length(input_string))
}


draw_text_ext_transformed(x+5*master_scale,y+image_yscale*sprite_get_height(sprite_index)/2*master_scale,string_hash_to_newline(string(draw_string)+string(str_cursor)),text_linesep*master_scale/fnt_scale,(sprite_width-10)/fnt_scale,fnt_scale*master_scale,fnt_scale*master_scale,0)
draw_set_color(c_white)
draw_text_transformed(x,y-image_yscale*sprite_get_height(sprite_index)/2*master_scale,string_hash_to_newline(label),fnt_scale*master_scale,fnt_scale*master_scale,0)

draw_set_alpha(1)

