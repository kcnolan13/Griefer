//don't drop things down infinite chasms
/*pass = false
for (i=0;i<(room_height-y)/20;i+=20)
{
    if collision_rectangle(bbox_left,bbox_top+i,bbox_right,bbox_bottom+i,block,true,true)
    pass = true
}
if pass = false
return false*/
//unstick from any blocks that may be overlapping upon creation
if is_string(varRead("myX")) or is_string(varRead("myY"))
{
    printf("ERROR: not supposed to be string: "+string(varRead("myX"))+", "+string(varRead("myY")))
    varWrite("myX",real(varRead("myX")))
    varWrite("myY",real(varRead("myY")))
}
for (i=0;i<100;i+=1)
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

if scr_super_unstick_guy()
    return true
else return false