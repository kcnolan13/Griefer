wheel_player = argument0
wheel_x = argument1
wheel_y = argument2
wheel_alpha = argument3
wheel_scale = argument4

//NEEDS SOME VARS THAT ONLY PLAYER HAS
if wheel_player.object_index != player
    return -1

weapon_hoffset = (sprite_get_width(spr_weapon_slot)/1.5)*wheel_scale
weapon_voffset = (sprite_get_height(spr_weapon_slot)+22)*wheel_scale

for (index=0; index<4; index++)
{
    if (index%2==0)
    {
        if (index==0)
            hoffset = weapon_hoffset
        else
            hoffset = -1*weapon_hoffset
            
        voffset = 0
    } else {
        hoffset = 0
        
        if (index==1)
            voffset = weapon_voffset
        else
            voffset = -1*weapon_voffset
    }
    
    if index=objVarRead(wheel_player,"weapon_index")
        weapon_flag = FL_HIGHLIGHTED
    else
        weapon_flag = FL_NORMAL
    
    draw_weapon_slot(objVarRead(wheel_player,"weapon"+string(index)),wheel_x+hoffset,wheel_y+voffset,wheel_scale,wheel_alpha,weapon_flag)
}



    
