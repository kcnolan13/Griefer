/// @description set text to "" for sensitivity controls
if is_sens
{
    text = ""
    text_normal = ""
}

action_inherited();
///draw is_sens

if is_sens and popped_in
{   
        
   // sens_percent = (sens_val-sens_low)/(sens_high - sens_low)
        
    if sens_percent < 0
        sens_percent = 0
    if sens_percent > 1
        sens_percent = 1
    
    //printf(":::sens_val = "+string(sens_val)+", sens_high = "+string(sens_high)+", sens_low = "+string(sens_low)+", sens_percent="+string(sens_percent))
        
    more_text = string(ceil(sens_divs*sens_percent))
    header_text = ""
    
    draw_set_alpha(alpha+0.2)
    draw_set_color(sens_bg)
    draw_rectangle(xs,top+sp,xf,top+height*scale-sp,false)
    draw_set_color(sens_col)
    draw_rectangle(xs,top+sp,xs+(xf-xs)*sens_percent,top+height*scale-sp,false)
    draw_set_font(fnt_hud_big)
    
    if sens_percent < 0.5
         draw_set_color(c_white)
    else draw_set_color(c_black)
    
    draw_set_halign(fa_center)
    draw_set_valign(fa_center)
        
    xpos = left+width*scale/2
    ypos = top+height*scale/2-10
    xpos += text_xoff*scale
    ypos += text_yoff*scale
    draw_text_ext_transformed(xpos,ypos,string_hash_to_newline(more_text),10,width*scale,scale,scale,0)
}

