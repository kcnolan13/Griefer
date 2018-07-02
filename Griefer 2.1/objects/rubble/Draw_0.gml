/// @description draw in air or to surface
if surface_exists(fx.surf_blood)  and truthval(global.gc[GC_SURFACES,1])
{
    surface_set_target(fx.surf_blood)
    draw_set_blend_mode_ext(fx.blood_src,fx.blood_dest)
    
    draw_sprite_ext(sprite,0,x,y,xscale,yscale,rot,blend,intensity)
    
    draw_set_blend_mode(bm_normal)
    surface_reset_target()
    
    instance_destroy()
    exit
}

