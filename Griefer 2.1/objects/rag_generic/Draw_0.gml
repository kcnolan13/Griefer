/// @description physics draw debug

if sprite_exists(sprite_index)
    draw_sprite_ext(sprite_index,image_index,x,y,scale*xscale,scale*yscale,image_angle+image_angoff,image_blend,image_alpha)
else
    printf("ERROR: rag_generic trying to draw nonexistent sprite: "+string(sprite_index))
    
if not in_match()
{
    draw_set_color(c_lime)
    draw_set_alpha(1)
    //draw_circle(x,y,10,false)
    physics_draw_debug()
    
    draw_set_color(c_red)
    for (var i=0; i<getLength(joint_xs); i++)
    {
        if i = 1
            draw_set_color(c_lime)
        if i = 2
            draw_set_color(c_aqua)
            
        draw_circle(x+jxs[i],y+jys[i],3,false)
    }
}

