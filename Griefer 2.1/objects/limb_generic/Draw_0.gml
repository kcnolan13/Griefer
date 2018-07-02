/// @description draw sprite_2draw
//draw_sprite_ext(sprite_index,image_index,x,y,image_xscale,image_yscale,image_angle,image_blend,image_alpha)
if sprite_exists(sprite_2draw)
    draw_sprite_ext(sprite_2draw,image_index,x,y,image_xscale*scale,image_yscale*scale,fakedirection,image_blend,image_alpha)

