/// @description draw the hit indicator
//printf("entering indicator draw")

if instance_exists(net_manager.local_player) and objVarRead(net_manager.local_player,"alive")
{
    
    hp = floor(objVarRead(net_manager.local_player,"hp"))
    
    if not net_manager.local_player.respawn_counter
    {
    
        draw_x = net_manager.local_player.x
        draw_y = net_manager.local_player.y
    
        draw_alpha1 = (100-hp)/100
        
        if hp < threshold_critical
        {
            draw_alpha2 = (threshold_critical-hp)/threshold_critical
            if DEBUG
                printf("hp is critical. 2nd indicator kicking in.")
        } 
        else 
        {
            draw_alpha2 = 0
        }
    }
    else
    {
        if net_manager.local_player.respawn_counter < 0.75*net_manager.local_player.respawn_delay
        {
            draw_alpha1 /= alpha_divisor
            draw_alpha2 /= 1+3*(alpha_divisor-1)
        }
    }
    
    draw_sprite_ext(spr_hit_indicator,0,draw_x+trigx(draw_radius1,dir+180),draw_y+trigy(draw_radius1,dir+180),indicator_scale,indicator_scale,dir+180,c_white,draw_alpha1)
    draw_sprite_ext(spr_hit_indicator3,0,draw_x+trigx(draw_radius2,dir+180),draw_y+trigy(draw_radius2,dir+180),indicator_scale,indicator_scale,dir+180,c_white,draw_alpha2)
    
} else if in_match(){
    if not instance_exists(net_manager.local_player)
        printf("ERROR: no local player")
    /*else if not objVarRead(net_manager.local_player,"alive")
        printf("WARNING: cursor knows localplayer is not alive: alive val: "+string(objVarRead(net_manager.local_player,"alive")))*/
}

//OLD FADE CODE
/*if alpha > 0
{
    if instance_exists(net_manager.local_player)
    {
        if objVarRead(net_manager.local_player,"hp") > 0
        {
            draw_x = net_manager.local_player.x
            draw_y = net_manager.local_player.y
        }
    } else
    {
        draw_x = view_xview+view_wview/2
        draw_y = view_yview+view_hview/2
    }
    //printf("drawing indicator")
    draw_sprite_ext(spr_hit_indicator,0,draw_x+trigx(draw_radius,dir+180),draw_y+trigy(draw_radius,dir+180),0.5,0.5,dir+180,c_white,alpha)
}*/

/* */
/*  */
