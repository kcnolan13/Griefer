/// @description draw sprite + label
draw_sprite(sprite_index,image_index,x,y)
draw_set_color(c_white)
draw_set_font(fnt)
draw_set_halign(halign)
draw_set_valign(valign)
if puretxt
{
    draw_set_alpha(txt_alpha)
}
    
if object_index = bn_start_matchmaking
    draw_text(x,y,string_hash_to_newline(game_mode_name(label)))
else
{
    if puretxt
    {
        draw_text_transformed(x,y,string_hash_to_newline(label),txt_scale,txt_scale,0)
    } else draw_text(x,y,string_hash_to_newline(label))
}

draw_set_alpha(1)

if object_index = bn_leaderboards and instance_place(x,y,cursor)
{
    draw_set_halign(fa_center)
    draw_set_valign(fa_center)
    draw_set_font(fnt_hud_big)
    draw_text(x,y+48,string_hash_to_newline("[allow popups]"))
}

