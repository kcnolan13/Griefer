//unstick from any blocks that may be overlapping
for (i=0;i<100;i+=1)
{
    if !collision_rectangle(bbox_left-0+i,bbox_top-0,bbox_right+0+i,bbox_bottom+0,block,true,true) && varRead("myX")+i > 0 && varRead("myX")+i < room_width
    and !collision_rectangle(bbox_left-0+i,bbox_top-0,bbox_right+0+i,bbox_bottom+0,block2_top,true,true)
    {varAdd("myX",i) return true}

    if !collision_rectangle(bbox_left-0-i,bbox_top-0,bbox_right+0-i,bbox_bottom+0,block,true,true) && varRead("myX")-i > 0 && varRead("myX")-i < room_width
    and !collision_rectangle(bbox_left-0-i,bbox_top-0,bbox_right+0-i,bbox_bottom+0,block2_top,true,true)
    {varSub("myX",i) return true}
    
    if !collision_rectangle(bbox_left-0,bbox_top-0+i,bbox_right+0,bbox_bottom+0+i,block,true,true) && varRead("myY")+i > 0 && varRead("myY")+i < room_height
    and !collision_rectangle(bbox_left-0,bbox_top-0+i,bbox_right+0,bbox_bottom+0+i,block2_top,true,true)
    {varAdd("myY",i) return true}
    
    if !collision_rectangle(bbox_left-0,bbox_top-0-i,bbox_right+0,bbox_bottom+0-i,block,true,true) && varRead("myY")-i > 0 && varRead("myY")-i < room_height
    and !collision_rectangle(bbox_left-0,bbox_top-0-i,bbox_right+0,bbox_bottom+0-i,block2_top,true,true)
    {varSub("myY",i) return true}
    
    if !collision_rectangle(bbox_left-0+i,bbox_top-0+i,bbox_right+0+i,bbox_bottom+0+i,block,true,true) && varRead("myX")+i > 0 && varRead("myX")+i < room_width && varRead("myY")+i > 0 && varRead("myY")+i < room_height
    and !collision_rectangle(bbox_left-0+i,bbox_top-0+i,bbox_right+0+i,bbox_bottom+0+i,block2_top,true,true)
    {varAdd("myX",i) varAdd("myY",i) return true}
    
    if !collision_rectangle(bbox_left-0+i,bbox_top-0-i,bbox_right+0+i,bbox_bottom+0-i,block,true,true) && varRead("myX")+i > 0 && varRead("myX")+i < room_width && varRead("myY")-i > 0 && varRead("myY")-i < room_height
    and !collision_rectangle(bbox_left-0+i,bbox_top-0-i,bbox_right+0+i,bbox_bottom+0-i,block2_top,true,true)
    {varAdd("myX",i) varSub("myY",i) return true} 
    
    if !collision_rectangle(bbox_left-0-i,bbox_top-0+i,bbox_right+0-i,bbox_bottom+0+i,block,true,true) && varRead("myX")-i > 0 && varRead("myX")-i < room_width && varRead("myY")+i > 0 && varRead("myY")+i < room_height
    and !collision_rectangle(bbox_left-0-i,bbox_top-0+i,bbox_right+0-i,bbox_bottom+0+i,block2_top,true,true)
    {varSub("myX",i) varAdd("myY",i) return true}
    
    if !collision_rectangle(bbox_left-0-i,bbox_top-0-i,bbox_right+0-i,bbox_bottom+0-i,block,true,true) && varRead("myX")-i > 0 && varRead("myX")-i < room_width && varRead("myY")-i > 0 && varRead("myY")-i < room_height
    and !collision_rectangle(bbox_left-0-i,bbox_top-0-i,bbox_right+0-i,bbox_bottom+0-i,block2_top,true,true)
    {varSub("myX",i) varSub("myY",i) return true}
}

return false