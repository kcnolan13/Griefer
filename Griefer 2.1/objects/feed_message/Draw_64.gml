/// @description draw av heads and stuff
alpha_scaler = snap_obj.alpha_scaler
var alph = min(alph_max,alpha)*alpha_scaler*alpha_scaler

if alph > 0.1
{
    draw_set_alpha(alph)
    
    var head_xoff = 1.75*sprite_get_width(spr_head)/2*avhead_scale*scale*master_scale
    if snap_obj = chat_feed
        head_xoff *= 1.5
    
    //draw the weapon
    if weapon > -1 and sprite_exists(weapon)
    {
        show_text = false
        var spr_width = sprite_get_bbox_right(weapon) - sprite_get_bbox_left(weapon)
        var spr_height = sprite_get_bbox_bottom(weapon) - sprite_get_bbox_top(weapon)
        var wepscale = (width*master_scale*2/3)/max(0.0005,spr_width)
        
        if spr_height*wepscale > height*master_scale*1.25
            wepscale = height*master_scale*1.25/spr_height //(height)/spr_height
            
        if weapon = spr_torque
            wepscale *= 1.5
            
        var wep_xoff = wepscale*(sprite_get_xoffset(weapon)-sprite_get_width(weapon)/2)
        var wep_yoff = wepscale*(sprite_get_yoffset(weapon)-sprite_get_height(weapon)/2)
        draw_sprite_ext(weapon,-1,x+wep_xoff,y+wep_yoff-15,wepscale,wepscale,0,c_white,draw_get_alpha())
    }
    
    if is_real(avhead1) and avhead1 > -1 and sprite_exists(avhead1)
    {
        if not instance_exists(av1)
            av1 = find_pname_avatar(avname1)
            
        if instance_exists(av1)
        {
            avhead1 = objVarRead(av1,"helmet0")
            avhat1 = objVarRead(av1,"hat0")
            color = team_color_pname(avname1)
        }
        
        varWrite("helmet0",avhead1)
        if avhat1 > -1 and sprite_exists(avhat1)
            varWrite("hat0",avhat1)
            
        var alph = draw_get_alpha()
        draw_set_alpha(alph*1)
        draw_avatar_head(x-width/2*master_scale-head_xoff,y-10*master_scale,id,0,avhead_scale*scale*master_scale,1,FL_NOBAR)
        draw_set_alpha(average3(alph,1,1))
        draw_set_font(fnt_feed)
        draw_set_color(c_white)
        draw_set_halign(fa_left)
        draw_text_transformed(x-width/2*master_scale-head_xoff*2,y,string_hash_to_newline(capwords(chop_string(avname1,max_length))),master_scale/2,master_scale/2,1)
        draw_set_alpha(alph)
    }
    
    if is_real(avhead2) and avhead2 > -1 and sprite_exists(avhead2)
    {
        if not instance_exists(av2)
            av2 = find_pname_avatar(avname2)
        
        if instance_exists(av2)
        {
            avhead2 = objVarRead(av2,"helmet0")
            avhat2 = objVarRead(av2,"hat0")
        }

        //draw splats for dead guy
        if instance_exists(deadguy)
        {
            draw_splats(x+width/2*master_scale+head_xoff,y-10*master_scale,0.225*master_scale,deadguy_blood_color,draw_get_alpha()/2)
        }
        varWrite("helmet0",avhead2)
        if avhat2 > -1 and sprite_exists(avhat2)
            varWrite("hat0",avhat2)
        var alph = draw_get_alpha()
        draw_set_alpha(alph*1)
        draw_avatar_head(x+width/2*master_scale+head_xoff,y-10*master_scale,id,0,avhead_scale*scale*master_scale,-1,FL_NOBAR)
        draw_set_alpha(average3(alph,1,1))
        draw_set_font(fnt_feed)
        draw_set_color(c_white)
        draw_set_halign(fa_right)
        draw_text_transformed(x+width/2*master_scale+head_xoff*2,y,string_hash_to_newline(capwords(chop_string(avname2,max_length))),master_scale/2,master_scale/2,1)
        draw_set_alpha(alph)
    }
}

draw_set_halign(fa_center)

if show_text
{
    event_inherited()
}

if notif_time
{
    draw_notification(1,x-width/2*master_scale+rect_xoff*master_scale,y-height/2*master_scale+rect_yoff*master_scale,1,notif_color,alpha_scaler)
}

