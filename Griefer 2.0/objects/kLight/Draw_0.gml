/// @description not much
counter++

if rot = 0 and not splosion_light//and not loc
    active = false
else 
{
    active = true
    if not surface_exists(lighting.surf)
    {
        return false
    }
    
    surface_set_target(lighting.surf)
    draw_set_blend_mode(bm_add)
    
    if in_view(id,64*4)
    {    
        c = 0
        repeat (intensity)
            draw_sprite_ext(sprite, -1, x, y, xscale, yscale, rot, color, 1)

        draw_sprite_ext(sprite, -1, x, y, xscale, yscale, rot, color, intensity%1)
    }
    
    draw_set_blend_mode(bm_normal)
    surface_reset_target()

}

