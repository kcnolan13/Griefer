///draw_modal_window()


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
    draw_set_alpha(alpha*alpha_scroll_scaler*alpha_scaler)
    draw_accolade()
    exit
}

if not surface_exists(surface)
{   
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
        draw_rectangle(left+rect_xoff*scale*master_scale-rect_xextra*scale*master_scale/2,top+rect_yoff*scale*master_scale-rect_yextra*scale*master_scale/2,left+width*scale*master_scale+rect_xoff*scale*master_scale+rect_xextra*scale*master_scale/2,top+(height+extra_height)*scale*master_scale+rect_yoff*scale*master_scale+rect_yextra*scale*master_scale/2,false)
        draw_set_alpha(alph)
    }
    drew_left = left
    drew_right = left+width*scale*master_scale
    
    if header_height > 0
    {
        draw_set_color(header_color)
        draw_rectangle(left+rect_xoff*scale*master_scale,top+header_height*scale*master_scale+rect_yoff*scale*master_scale,left+width*scale*master_scale+rect_xoff*scale*master_scale,top+rect_yoff*scale*master_scale,false)
    }
    
    if image != spr_none
    {
        draw_sprite_ext(image,img_index,left+rect_xoff*scale*master_scale,top+rect_yoff*scale*master_scale,scale*master_scale,scale*master_scale,0,c_white,1)
    }
    
    if text != "" or header_text != ""
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
        
        if text_halign = fa_center
            draw_text_ext_transformed(xpos+text_pad,ypos,text,text_linesep,(width-text_pad*2)*scale,scale*master_scale,scale*master_scale,0)
        else
            draw_text_ext_transformed(xpos,ypos,text,text_linesep,(width-text_pad*2)*scale,scale*master_scale,scale*master_scale,0)
        
        if header_height > 0
        {
            draw_set_font(header_font)
            draw_set_color(header_text_color)
            draw_set_halign(text_halign)
            draw_set_valign(fa_center)
            draw_text_ext_transformed(xpos+header_xoff,top+header_yoff+header_height*scale*master_scale/2,header_text,text_linesep,width*scale,scale*master_scale,scale*master_scale,0)
        }
        
        draw_set_alpha(alpha*alpha_scaler)
    }
    
    draw_set_alpha(1)
}
else
{
    ///just draw whatever is on the surface
    draw_surface_general(surface,0,0,width,height,left,top,1,1,0,c_white,c_white,c_white,c_white,1)
    //draw_surface(surface,left,top,width*scale,height*scale)
}