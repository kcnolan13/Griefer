/// @description draw in air or to surface
if surface_exists(fx.surf_blood) and trailing and truthval(global.gc[GC_SURFACES,1])
{
    surface_set_target(fx.surf_blood)
    //draw_set_blend_mode_ext(fx.blood_src,fx.blood_dest)
    draw_set_blend_mode(bm_normal)
    
    if xscale > 0.01
        mult = 0.85
    else
        mult = 0.998
    
    yscale *= mult
    xscale *= mult
    
    prescaler = random_range(0.6,1)
    
    if not splatted
        prescaler = 1.5
    
    sprite_index = spr_splat
    
    if random(1) < 0.6 or not splatted
    {
        //reset the big blood surface fade delay
        fx.bfade_delay = fx.bfade_max
        splatted = true
        draw_sprite_ext(spr_splat,floor(random_range(0,image_number+0.99)),x,y,xscale*prescaler,yscale*prescaler,rot,blend,0.85*alpha)
    }
    draw_set_blend_mode(bm_normal)
    surface_reset_target()
} else if not trailing
{
    //draw_set_blend_mode_ext(fx.blood_src,fx.blood_dest)
    draw_set_blend_mode(bm_normal)
    //repeat(6)
    {
        xscala = xscale*spd/3
        if xscala > 2.5 xscala = 2.5
        
        if xscala < 0.2
            xscala = 0.2
        
        yscala = 1//average4(xscala,1,1,1)
        prescaler = 0.575
            
        draw_sprite_ext(sprite,0,x,y,xscale*xscala*prescaler,yscale*yscala*prescaler,dir,blend,0.65*alpha)
        
        //DRAW THE TRAJECTORY
        var xi = x
        var yi = y
        var tdir = dir
        var rigidity = 3
        var color = blend
        var width = 9
        var resolution = 1
        var length = 48
        var highlight = spr_none
        var highlight_interval = 1280
        var alpha1 = 0
        var alpha2 = 0.5
        var alpha3 = 0.5
        var flag = FL_DISAPPEAR
       // draw_trajectory(xi, yi, spd, tdir, grav, rigidity, color, width, resolution, length, highlight, highlight_interval, alpha1, alpha2, alpha3, flag)
        
    }
    draw_set_blend_mode(bm_normal)
}

if destroy = 1
    instance_destroy()

