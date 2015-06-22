///scr_unstick_tossable_trajectory(square_sprite)
var width = sprite_get_width(argument0)

var var_bbox_top = ynow-width/2
var var_bbox_left = xnow-width/2
var var_bbox_right = xnow+width/2
var var_bbox_bottom = ynow+width/2

for (i=0;i<100;i+=1)
{
    if !collision_rectangle(var_bbox_left-0+i,var_bbox_top-0,var_bbox_right+0+i,var_bbox_bottom+0,block,true,true) && xnow+i > 0 && xnow+i < room_width
    and !collision_rectangle(var_bbox_left-0+i,var_bbox_top-0,var_bbox_right+0+i,var_bbox_bottom+0,block2_top,true,true)
    {xnow+=i return true}

    if !collision_rectangle(var_bbox_left-0-i,var_bbox_top-0,var_bbox_right+0-i,var_bbox_bottom+0,block,true,true) && xnow-i > 0 && xnow-i < room_width
    and !collision_rectangle(var_bbox_left-0-i,var_bbox_top-0,var_bbox_right+0-i,var_bbox_bottom+0,block2_top,true,true)
    {xnow-=i return true}
    
    if !collision_rectangle(var_bbox_left-0,var_bbox_top-0+i,var_bbox_right+0,var_bbox_bottom+0+i,block,true,true) && ynow+i > 0 && ynow+i < room_height
    and !collision_rectangle(var_bbox_left-0,var_bbox_top-0+i,var_bbox_right+0,var_bbox_bottom+0+i,block2_top,true,true)
    {ynow+=i return true}
    
    if !collision_rectangle(var_bbox_left-0,var_bbox_top-0-i,var_bbox_right+0,var_bbox_bottom+0-i,block,true,true) && ynow-i > 0 && ynow-i < room_height
    and !collision_rectangle(var_bbox_left-0,var_bbox_top-0-i,var_bbox_right+0,var_bbox_bottom+0-i,block2_top,true,true)
    {ynow-=i return true}
    
    if !collision_rectangle(var_bbox_left-0+i,var_bbox_top-0+i,var_bbox_right+0+i,var_bbox_bottom+0+i,block,true,true) && xnow+i > 0 && xnow+i < room_width && ynow+i > 0 && ynow+i < room_height
    and !collision_rectangle(var_bbox_left-0+i,var_bbox_top-0+i,var_bbox_right+0+i,var_bbox_bottom+0+i,block2_top,true,true)
    {xnow+=i ynow+=i return true}
    
    if !collision_rectangle(var_bbox_left-0+i,var_bbox_top-0-i,var_bbox_right+0+i,var_bbox_bottom+0-i,block,true,true) && xnow+i > 0 && xnow+i < room_width && ynow-i > 0 && ynow-i < room_height
    and !collision_rectangle(var_bbox_left-0+i,var_bbox_top-0-i,var_bbox_right+0+i,var_bbox_bottom+0-i,block2_top,true,true)
    {xnow+=i ynow-=i return true} 
    
    if !collision_rectangle(var_bbox_left-0-i,var_bbox_top-0+i,var_bbox_right+0-i,var_bbox_bottom+0+i,block,true,true) && xnow-i > 0 && xnow-i < room_width && ynow+i > 0 && ynow+i < room_height
    and !collision_rectangle(var_bbox_left-0-i,var_bbox_top-0+i,var_bbox_right+0-i,var_bbox_bottom+0+i,block2_top,true,true)
    {xnow-=i ynow+=i return true}
    
    if !collision_rectangle(var_bbox_left-0-i,var_bbox_top-0-i,var_bbox_right+0-i,var_bbox_bottom+0-i,block,true,true) && xnow-i > 0 && xnow-i < room_width && ynow-i > 0 && ynow-i < room_height
    and !collision_rectangle(var_bbox_left-0-i,var_bbox_top-0-i,var_bbox_right+0-i,var_bbox_bottom+0-i,block2_top,true,true)
    {xnow-=i ynow-=i return true}
}

return false