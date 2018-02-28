/// @description draw sprite_2draw
//draw_sprite_ext(sprite_index,image_index,x,y,image_xscale,image_yscale,image_angle,image_blend,image_alpha)
if object_index != bullet_torque
    var draw_ang = fakedirection
else var draw_ang = dir_perm

draw_sprite_ext(sprite_2draw,image_index,x,y,image_xscale*varRead("scale"),image_yscale*varRead("scale"),draw_ang,image_blend,image_alpha)

