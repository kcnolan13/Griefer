exit;
///draw me
draw_set_font(fnt_hud_big)
draw_set_color(c_white)
draw_set_halign(fa_left)
draw_set_valign(fa_center)

draw_sprite(sprite_index,image_index,x,y)
if active
    draw_set_alpha(1)
else
    draw_set_alpha(0.65)
draw_text(x+sprite_get_width(sprite_index)+10,y+sprite_get_height(sprite_index)/2,string_hash_to_newline(label))

draw_set_alpha(1)

