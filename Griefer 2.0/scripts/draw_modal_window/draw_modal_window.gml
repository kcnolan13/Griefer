/// @description draw_modal_window()
/// @function draw_modal_window


if halign = fa_center
    left -= width*scale*master_scale/2
if halign = fa_right
    left -= width*scale*master_scale/2
    
if valign = fa_center
    top -= height*scale*master_scale/2
if valign = fa_bottom
    top -= height*scale*master_scale/2
    
if object_index = accolade_generic
{
    var alph = alpha*alpha_scroll_scaler*alpha_scaler
    if alph > 0.075
    {
        draw_set_alpha(alph)
        draw_accolade()
    }
    exit
}

if not surface_exists(surface)
{
    if not is_3d or not surf_3d_ready
    {
        if is_3d and not surf_3d_ready
        {
            alpha_scaler = 1
            scale = scale_normal
            master_scale = 1
            alpha = 1
            
            if surface_exists(surf_3d)
            {
                surface_set_target(surf_3d)
            }
            else
            {
                printf("::: GENERATING SURF_3D FOR MODAL WINDOW")
                surf_3d = surface_create(width,height)
                surf_3d_ready = true
                tex_3d = NO_HANDLE
            }
        }
        
        if active
            draw_set_color(active_color)
        else
        {
            if color_highlighted = GARBAGE or not modal_highlighted(id)
                draw_set_color(color)
            else draw_set_color(color_highlighted)
        }
            
        if draw_rect
        {
            var alph = draw_get_alpha()
            draw_set_alpha(alph*rect_alpha*alpha_scaler)
            if is_gui or (not draw_gradient or omit_internal_gradient)
                draw_rectangle(left+rect_xoff*scale*master_scale-rect_xextra*scale*master_scale/2,top+rect_yoff*scale*master_scale-rect_yextra*scale*master_scale/2,left+width*scale*master_scale+rect_xoff*scale*master_scale+rect_xextra*scale*master_scale/2,top+(height+extra_height)*scale*master_scale+rect_yoff*scale*master_scale+rect_yextra*scale*master_scale/2,false)
            else
                draw_rectangle_colour(left+rect_xoff*scale*master_scale-rect_xextra*scale*master_scale/2,top+rect_yoff*scale*master_scale-rect_yextra*scale*master_scale/2,left+width*scale*master_scale+rect_xoff*scale*master_scale+rect_xextra*scale*master_scale/2,top+(height+extra_height)*scale*master_scale+rect_yoff*scale*master_scale+rect_yextra*scale*master_scale/2,grad1,grad2,grad3,grad4,false)
            draw_set_alpha(alph)
        }
        drew_left = left
        drew_right = left+width*scale*master_scale
        
        if image != spr_none
        {
            var img_xsc = scale*master_scale
            var img_ysc = scale*master_scale
            
            var img_x = left+(rect_xoff+image_xoff)*scale*master_scale
            var img_y = top+(rect_yoff+image_yoff)*scale*master_scale
            
            if image_halign = fa_center
                img_x += width*scale*master_scale/2
            if image_valign = fa_center or image_valign = fa_middle
                img_y += height*scale*master_scale/2
            
            if image_stretch
            {
                if not image_is_bg
                {
                    img_xsc = ceil(img_xsc*width/sprite_get_width(image))
                    img_ysc = ceil(img_ysc*height/sprite_get_height(image))
                }
                else
                {
                    img_xsc = ceil(img_xsc*width/max(0.1,background_get_width(image)))
                    img_ysc = ceil(img_ysc*height/max(0.1,background_get_width(image)))
                }
            }
            else
            {
                if image_stretch_x
                {
                    if not image_is_bg
                        img_xsc = ceil(img_xsc*width/sprite_get_width(image))
                    else
                        img_xsc = ceil(img_xsc*width/max(0.1,background_get_width(image)))
                }
                    
                if image_stretch_y
                {
                    if not image_is_bg
                        img_ysc = ceil(img_ysc*height/sprite_get_height(image))
                    else
                        img_ysc = ceil(img_ysc*height/max(0.1,background_get_height(image)))
                    
                }
            }   
            
            if not image_crop
            {
                if not image_is_bg
                    draw_sprite_ext(image,img_index,img_x,img_y,img_xsc*img_xscale,img_ysc*img_yscale,0,img_blend,alpha*alpha_scaler)
                else
                    draw_background_ext(image,img_x,img_y,img_xsc*img_xscale,img_ysc*img_yscale,0,img_blend,alpha*alpha_scaler)
            }
            else
            {
                var img_yst = 0
                var img_xst = 0
                
                if image_crop_align = fa_center
                {
                    var y_coverage = height*scale*master_scale/img_ysc/img_yscale
                    img_yst = (sprite_get_height(image)-y_coverage)/2
                    if img_yst < 0
                        img_yst = 0
                        
                    var x_coverage = width*scale*master_scale/img_xsc/img_xscale
                    img_xst = (sprite_get_width(image)-x_coverage)/2
                    if img_xst < 0
                        img_xst = 0
                }
                
                if not image_is_bg
                    draw_sprite_part_ext(image,img_index,img_xst,img_yst,width*scale*master_scale/img_xsc/img_xscale,height*scale*master_scale/img_ysc/img_yscale,img_x,img_y,img_xsc*img_xscale,img_ysc*img_yscale,img_blend,alpha*alpha_scaler)
                else
                    draw_background_part_ext(image,img_xst,img_yst,width*scale*master_scale/img_xsc/img_xscale,height*scale*master_scale/img_ysc/img_yscale,img_x,img_y,img_xsc*img_xscale,img_ysc*img_yscale,img_blend,alpha*alpha_scaler)
            
            }
        }
        
        if draw_image_gradient
        {   draw_set_alpha(draw_get_alpha()*image_gradient_alpha)
                draw_rectangle_colour(left+rect_xoff*scale*master_scale-rect_xextra*scale*master_scale/2,top+rect_yoff*scale*master_scale-rect_yextra*scale*master_scale/2,left+width*scale*master_scale+rect_xoff*scale*master_scale+rect_xextra*scale*master_scale/2,top+(height+extra_height)*scale*master_scale+rect_yoff*scale*master_scale+rect_yextra*scale*master_scale/2,grad1,grad2,grad3,grad4,false)
            draw_set_alpha(draw_get_alpha()/image_gradient_alpha)
        }
        
        if header_height > 0
        {
            draw_set_color(header_color)
            var alph = draw_get_alpha()
            draw_set_alpha(alpha*alpha_scaler*header_alpha)
            draw_rectangle(left+rect_xoff*scale*master_scale,top+header_height*scale*master_scale+rect_yoff*scale*master_scale,left+width*scale*master_scale+rect_xoff*scale*master_scale,top+rect_yoff*scale*master_scale,false)
            draw_set_alpha(alph)
        }
        
        if border_width > 0
        {
            draw_set_color(border_color)
            draw_set_alpha(draw_get_alpha()*border_alpha)
            
            var bsign = 1
            if border_inscribe
                bsign = -1
            
            for (var i=0; i<border_width; i+=0.5)
            {
                draw_rectangle(left-i*bsign,top-i*bsign,left+width+i*bsign,top+height+i*bsign,true)
            }
            draw_set_color(c_white)
            draw_set_alpha(draw_get_alpha()/border_alpha)
        }
        
        if string(text) != "" or string(header_text) != "" or (object_index = bn_input_field and string_length(string(str_cursor)) > 0) or string(tooltip) != ""
        {
            if text_alpha_override
            draw_set_alpha(1*alpha_scaler)
            
            draw_set_font(font)
            draw_set_color(text_color)
            draw_set_halign(fa_center)
            draw_set_valign(fa_middle)
            
            xpos = left+width*scale*master_scale/2+rect_xoff*scale*master_scale
            ypos = top+height*scale*master_scale/2+rect_yoff*scale*master_scale
            
            if text_halign = fa_right
            {
                draw_set_halign(fa_right)
                xpos = left+(width*scale-6)*master_scale
            }
            
            if text_halign = fa_left
            {
                draw_set_halign(fa_left)
                xpos = left+2*scale*master_scale
            }
            
            if text_valign = fa_top
            {
                draw_set_valign(fa_top)
                ypos = top+2*scale*master_scale
            }
            
            if text_valign = fa_bottom
            {
                draw_set_valign(fa_bottom)
                ypos = top+height*scale*master_scale-25*scale*master_scale
            }
            
            xpos += text_xoff*scale*master_scale
            ypos += text_yoff*scale*master_scale
            
            var text_2draw = text
			
            if object_index = bn_input_field {
				if is_password and text != "Password" {
					text_2draw = ""
					for (i=1; i<string_length(text); i++) {
						text_2draw += "*"
					}
					text_2draw += string_char_at(text,string_length(text))
				}
				if active {
					text_2draw += string(str_cursor)
				}
			}
                
            //THE LOADING WHEEL THING (bumps text over a little to make room)
            if is_loading
            {
                for (var i=0; i<load_points; i++)
                {
                    var ang = load_rot+(i/load_points)*360
                    var point_rad = (load_point_rad_min+(i/load_points)*(load_point_rad_max-load_point_rad_min))*scale*master_scale
                    var px = xpos + trigx(load_rad,ang)*scale*master_scale
                    var py = ypos + trigy(load_rad,ang)*scale*master_scale
                    draw_circle(px,py,point_rad,false)
                }
                xpos += (load_rad+load_text_hsep)*scale*master_scale
                
                repeat(floor(loading_counter))
                    text_2draw += "."
            }
            
            if text_halign = fa_center
                draw_text_ext_transformed(xpos,ypos,string_hash_to_newline(text_2draw),text_linesep,(width-text_pad*2-text_xoff),scale*master_scale,scale*master_scale,0)
            else if text_halign = fa_left
                draw_text_ext_transformed(xpos+text_pad,ypos,string_hash_to_newline(text_2draw),text_linesep,(width-text_pad*2-text_xoff),scale*master_scale,scale*master_scale,0)
            else
                draw_text_ext_transformed(xpos-text_pad,ypos,string_hash_to_newline(text_2draw),text_linesep,(width-text_pad*2-text_xoff),scale*master_scale,scale*master_scale,0)
            
            if header_text != ""
            {
                draw_set_font(header_font)
                draw_set_color(header_text_color)
                draw_set_halign(text_halign)
                draw_set_valign(fa_center)
                draw_text_ext_transformed(xpos+header_xoff,top+header_yoff+header_height*scale*master_scale/2,string_hash_to_newline(header_text),text_linesep,width-text_pad*2-text_xoff,scale*master_scale,scale*master_scale,0)
            }
			
			if text2 != ""
			{
                draw_set_font(text2_font)
                draw_set_color(text2_color)
                draw_set_halign(text2_halign)
                draw_set_valign(text2_valign)
                draw_text_ext_transformed(xpos+text2_xoff*scale*master_scale,top+text2_yoff*scale*master_scale,string_hash_to_newline(text2),text2_linesep,width-text2_pad*2,scale*master_scale,scale*master_scale,0)
            }
			
			if tooltip != "" and show_popup
			{
                draw_set_font(tooltip_font)
                draw_set_color(tooltip_color)
                draw_set_halign(tooltip_halign)
                draw_set_valign(tooltip_valign)
                draw_text_ext_transformed(xpos+tooltip_xoff,top+tooltip_yoff,string_hash_to_newline(tooltip),tooltip_linesep,tooltip_width-tooltip_pad*2,scale*master_scale,scale*master_scale,0)
            }
            
            draw_set_alpha(alpha*alpha_scaler)
        }
        
        draw_set_alpha(1)
        if is_3d and surface_exists(surf_3d)
        {
            surface_reset_target()
        }
    }
    else if is_3d and surf_3d_ready
    {
        //draw 3d rotating surface!!
        /*
        rot_3d ++
        rot_3d = constrict(rot_3d,0,360)
        
        if tex_3d = NO_HANDLE
            tex_3d = surface_get_texture(surf_3d)
        
            d3d_transform_set_identity()
            d3d_transform_add_rotation_z(rot_3d)
            d3d_transform_add_translation(x,y,0)
            draw_set_color(c_white)
            d3d_set_culling(true)
            d3d_set_hidden(true)
            d3d_draw_floor(-width/2,-height/2,0,width/2,height/2,0,tex_3d,0,0)
            d3d_transform_set_identity()
        */
    }
}
else
{
    ///just draw whatever is on the surface
    draw_surface_general(surface,0,0,width,height,left,top,1,1,0,c_white,c_white,c_white,c_white,1)
    //draw_surface(surface,left,top,width*scale,height*scale)
}
