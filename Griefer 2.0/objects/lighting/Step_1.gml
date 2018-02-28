/// @description render lights onto lighting surface

if in_match() and truthval(global.gc[GC_PARTICLES,1])
{
    if not surface_exists(surf)
    {
        free_lighting_surfaces()
        regen_lighting_surfaces()
    }
    surface_set_target(surf)
    draw_clear_alpha(c_black,0)
    surface_reset_target()
}

