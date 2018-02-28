/// @description recompute parallax

if recompute_parallax
    recompute_parallax = false
    
if recompute_parallax and false
{
    for (var i=0; i<getLength(surfs); i++)
    {
        if surface_exists(surfs[i])
            surface_free(surfs[i])
    }
    
    for (var i=0; i<getLength(surf_inverses); i++)
    {
        if surface_exists(surf_inverses[i])
                surface_free(surf_inverses[i])
    }
            
    layers = 0
    xoffables = 0 //how many WVIEW's per view moving WVIEW px's
    yoffables = 0
    yoffable_scale = 1 //yoffables computed from yoffable_scale
    tbottoms = 0 //FL_TOP or FL_BOTTOM
    blend_tops = 0
    blend_bottoms = 0
    
    tex_scale = 1
    tex_scales = 0  //an array of texture scales -- should vaguely adjust with distance
    tex = spr_none
    tex_alpha = 0
    tex_alphas = 0
    tex_alpha_inc = 0
    tex_scale_scaler = 0.75 //how much to prescale normal distance scaling
    
    alphas = 0
    hue = 0
    sat = 0
    val = 0
    alpha = 1
    hue_inc = 0
    sat_inc = 0
    val_inc = 0
    alpha_inc = -0.0025
    is_grad = false
    grad_voff = 30

    //CUSTOM PARALLAX FOR EACH ROOM
    switch (room)
    {
        case rm_double:
        
            global.map_colors[rm_double,0] = web_hsv(0,3,86)
            global.map_colors[rm_double,1] = web_hsv(0,25,35)
            global.map_texs[rm_double] = bg_none
            global.col_alphas[rm_double] = 1
            
            //layers[0] = bg_mts1 tbottoms[0] = FL_BOTTOM xoffables[0] = 0.6
            //layers[1] = bg_mts2 tbottoms[1] = FL_BOTTOM xoffables[1] = 0.3
            //layers[2] = bg_mts3 tbottoms[2] = FL_BOTTOM xoffables[2] = 0.15
            //layers[3] = bg_mts4 tbottoms[3] = FL_BOTTOM xoffables[3] = 0.05
            yoffable_scale = 1.5
            
            hue = 348 sat = 12 val = 17
            hue_inc = 0 sat_inc = 0 val_inc = 10
            
            is_grad = true
            grad_voff = -10
            
            tex = bg_double_overlay2
            tex_alpha = 0.65
            tex_alpha_inc = -0.1
            
        break
        
        
        default:
            //no parallax for traditional rooms
        break
    }
    
    //GENERATE SURFACES
    for (var i=0; i<getLength(layers); i++)
    { 
        if not is_grad
            grad_voff = 0

        blend_tops[i] = web_hsv(hue+i*hue_inc,sat+i*sat_inc,val+i*val_inc-grad_voff)
        blend_bottoms[i] = web_hsv(hue+i*hue_inc,sat+i*sat_inc,val+i*val_inc+grad_voff)
        alphas[i] = alpha+i*alpha_inc
        yoffables[i] = xoffables[i]*yoffable_scale
        
        tex_alphas[i] = tex_alpha + i*tex_alpha_inc
        tex_scales[i] = tex_scale * lerp_real(tex_scale,xoffables[i]/xoffables[0],tex_scale_scaler)
        
        surfs[i] = surface_create(WVIEW,HVIEW)
        surf_inverses[i] = surface_create(WVIEW,HVIEW)
        
        //figure out where the silhouette goes and whatnot
        surface_set_target(surfs[i])
            draw_set_color(c_white)
            draw_set_alpha(1)
            draw_set_blend_mode(bm_normal)
            draw_clear_alpha(c_black,0)
            //draw the actual parallax silhouette thing
            draw_background_ext(layers[i],0,0,1,1,0,c_white,1)
        surface_reset_target()
        
        //create the inverse surface
        surface_set_target(surf_inverses[i])
            draw_set_color(c_white)
            draw_set_alpha(1)
            draw_rectangle(0,0,WVIEW,HVIEW,false)
            draw_set_blend_mode(bm_subtract)
            draw_surface(surfs[i],0,0)
            draw_set_blend_mode(bm_normal)
        surface_reset_target()
        
        //now draw onto the real surface here
            surface_set_target(surfs[i])
                draw_set_blend_mode(bm_normal)
                draw_clear_alpha(c_black,0)
                //the colors
                draw_set_alpha(1)
                draw_rectangle_colour(0,0,WVIEW,HVIEW,blend_tops[i],blend_tops[i],blend_bottoms[i],blend_bottoms[i],false)
                //the texture
                if tex != spr_none
                    draw_background_tiled_ext(tex,0,0,tex_scales[i],tex_scales[i],c_white,tex_alphas[i])
    
                //subtract the inverse of the surface
                draw_set_blend_mode(bm_subtract)
                draw_surface_ext(surf_inverses[i],0,0,1,1,0,c_black,1)
                draw_set_blend_mode(bm_normal)
            surface_reset_target()
        
        //free the inverse
        surface_free(surf_inverses[i])
    }
}

///draw the background + parallax elements
if in_match()
{
    //draw bg colors and stuff
    draw_set_color(c_white)
    draw_set_alpha(1)
    

    {
        draw_background_tiled(global.map_texs[room],0,0)
    }

    {
        draw_set_alpha(global.col_alphas[room])
        draw_rectangle_colour(0,0,room_width,room_height,global.map_colors[room,0],global.map_colors[room,0],global.map_colors[room,1],global.map_colors[room,1],false)
    }
    //draw_background_tiled_ext(bg_stone,view_xview-view_xview/3,view_yview-view_yview/2.2,1,1,c_white,0.75)
    
    //DRAW PARALLAX
    /*for (var i=getLength(layers)-1; i>=0; i--)
    {
        var xst = view_xview
        var yst = view_yview+view_hview-HVIEW
        
        var xoff = view_xview*xoffables[i]*-1
        var yoff = -1*view_yview*yoffables[i]
        
        if tbottoms[i] = FL_BOTTOM
        {
            yoff = (room_height-(view_yview+view_hview))*yoffables[i]
        }
        
        draw_surf_tiled_hor(surfs[i],xst+xoff,yst+yoff,1,1,c_white,alphas[i])
    }*/
    
    //make all these elements a bit darker
    draw_set_alpha(0.25)
    draw_rectangle_color(__view_get( e__VW.XView, 0 )-64*3,__view_get( e__VW.YView, 0 )-64*3,__view_get( e__VW.XView, 0 )+__view_get( e__VW.WView, 0 )+64*3,__view_get( e__VW.YView, 0 )+__view_get( e__VW.HView, 0 )+64*3,c_black,c_black,c_black,c_black,false)
    draw_set_alpha(1)
} else if room != rm_login
{
    var h = colour_get_hue(global.bg_color)
    var s = colour_get_saturation(global.bg_color)
    var v = colour_get_value(global.bg_color)
    draw_background_ext(bg_menu2,0,0,1,1,0,make_colour_hsv(h,s/5,255),1)
}
else
{
    var color1 = web_hsv(0,0,100)
    var color2 = web_hsv(0,0,50)
    
    draw_rectangle_colour(0,HVIEW/6,WVIEW,HVIEW,color1,color1,color2,color2,false)
}

//var col = c_black
//draw_rectangle_colour(0,0,room_width,room_height,col,col,col,col,false)

/* */
/*  */
