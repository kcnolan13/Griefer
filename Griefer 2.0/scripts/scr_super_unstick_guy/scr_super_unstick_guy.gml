/// @description scr_super_unstick_guy

//bad programming at its finest
if object_index = weapon_ink
    return true

//the normal script
printf("::: super unstick guy")
for (i=0;i<128;i+=4)
{
    if !collision_rectangle(bbox_left-2+i,bbox_top-2,bbox_right+2+i,bbox_bottom+2,block,true,true) && varRead("myX")+i > 0 && varRead("myX")+i < room_width
    {varAdd("myX",i) return true}

    if !collision_rectangle(bbox_left-2-i,bbox_top-2,bbox_right+2-i,bbox_bottom+2,block,true,true) && varRead("myX")-i > 0 && varRead("myX")-i < room_width
    {varSub("myX",i) return true}
    
    if !collision_rectangle(bbox_left-2,bbox_top-2+i,bbox_right+2,bbox_bottom+2+i,block,true,true) && varRead("myY")+i > 0 && varRead("myY")+i < room_height
    {varAdd("myY",i) return true}
    
    if !collision_rectangle(bbox_left-2,bbox_top-2-i,bbox_right+2,bbox_bottom+2-i,block,true,true) && varRead("myY")-i > 0 && varRead("myY")-i < room_height
    {varSub("myY",i) return true}
    
    if !collision_rectangle(bbox_left-2+i,bbox_top-2+i,bbox_right+2+i,bbox_bottom+2+i,block,true,true) && varRead("myX")+i > 0 && varRead("myX")+i < room_width && varRead("myY")+i > 0 && varRead("myY")+i < room_height
    {varAdd("myX",i) varAdd("myY",i) return true}
    
    if !collision_rectangle(bbox_left-2+i,bbox_top-2-i,bbox_right+2+i,bbox_bottom+2-i,block,true,true) && varRead("myX")+i > 0 && varRead("myX")+i < room_width && varRead("myY")-i > 0 && varRead("myY")-i < room_height
    {varAdd("myX",i) varSub("myY",i) return true} 
    
    if !collision_rectangle(bbox_left-2-i,bbox_top-2+i,bbox_right+2-i,bbox_bottom+2+i,block,true,true) && varRead("myX")-i > 0 && varRead("myX")-i < room_width && varRead("myY")+i > 0 && varRead("myY")+i < room_height
    {varSub("myX",i) varAdd("myY",i) return true}
    
    if !collision_rectangle(bbox_left-2-i,bbox_top-2-i,bbox_right+2-i,bbox_bottom+2-i,block,true,true) && varRead("myX")-i > 0 && varRead("myX")-i < room_width && varRead("myY")-i > 0 && varRead("myY")-i < room_height
    {varSub("myX",i) varSub("myY",i) return true}
}
return false
