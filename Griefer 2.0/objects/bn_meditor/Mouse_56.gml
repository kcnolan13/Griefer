/// @description do stuff
if modal_highlighted(id)
{
    
    //toggle toggles
    if is_toggle
    {
        slider_value ^= 1
    }

    //adjust bindings
    if id = fx.bn_alpha_grad {
        fx.lvl_alpha_grad = slider_value
    } else if id = fx.bn_grad1 {
        fx.lvl_grad1 = global.color_picker
        color = global.color_picker
    } else if id = fx.bn_grad2 {
        fx.lvl_grad2 = global.color_picker
        color = global.color_picker
    } else if id = fx.bn_grad3 {
        fx.lvl_grad3 = global.color_picker
        color = global.color_picker
    } else if id = fx.bn_grad4 {
        fx.lvl_grad4 = global.color_picker
        color = global.color_picker
    } else if id = fx.bn_alpha_tex {
        fx.lvl_alpha_tex = slider_value
    } else if id = fx.bn_tex_above {
        fx.lvl_tex_above = slider_value
    } else if id = fx.bn_map_col0 {
        global.map_colors[room,0] = global.color_picker
        color = global.color_picker
    } else if id = fx.bn_map_col1 {
        global.map_colors[room,1] = global.color_picker
        color = global.color_picker
    } else if id = fx.bn_map_texs {
        global.map_texs[room] = slider_value
    } else if id = fx.bn_col_alphas {
        global.col_alphas[room] = slider_value
    } else if id = fx.bn_export {
        slider_value = 1
        export_level_colors()
    }
    
    if is_texture and uses_capture and not capturing
    {
        do_gen = true
        with (bn_meditor)
        {
            if (is_texture and not uses_capture) or capturing
                other.do_gen = false
        }
        if do_gen
        {
            capturing = true
            var bdelay = 5
            var bmas = 1
            var num_per_row = 8
            var first = bg_tex_start+1
            var last = bg_tex_end-1
            var row_index = 1
            var w = 64
            var h = 64
            var spacer = 20
            var xst = WVIEW/2 - (w+spacer)*num_per_row/2
            var yst = y+height/2+64*2
            
            for (var i=first; i<=last; i++)
            {
                if row_index > num_per_row
                {
                    row_index = 0
                    yst += h + spacer
                }
                
                ID = instance_create(xst+row_index*(w+spacer),yst,bn_meditor)
                ID.is_texture = true
                ID.image = i
                //ID.image_stretch_x = true
                ID.image_stretch = true
                ID.image_crop = true
                ID.capture_master = id
                ID.birth_delay = bdelay
                ID.image_is_bg = true
                ID.width = 48
                ID.height = 48
                bdelay += bmas
                
                row_index++
            }
        }
    }
    
    if is_texture and not uses_capture
    {
        if instance_exists(capture_master)
        {
            with capture_master
            {
                image = other.image
                capturing = false
                
                if id = fx.bn_tex 
                {
                    fx.lvl_tex = image
                } 
                else if id = fx.bn_map_texs 
                {
                    global.map_texs[room] = image   
                }
                
                with fx free_level_surfaces()
                
            }
        } else {
            printf("ERROR: clicked on meditor texture thingy but it has no master")
        }
        with (bn_meditor)
        {
            if is_texture and not uses_capture
                fade_out = true
        }
    }
    
    if not is_texture 
        with fx free_level_surfaces()
}

