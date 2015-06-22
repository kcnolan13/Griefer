resolution = argument0
for (i=0;i<28;i+=resolution)
{
    if !collision_rectangle(bbox_left+amount*sign(hsp),bbox_top-i,bbox_right+amount*sign(hsp),bbox_bottom-i,block,true,true)
    && (standing_2way = false || (standing_2way = true && !collision_rectangle(bbox_left+amount*sign(hsp),bbox_bottom-5-i,bbox_right+amount*sign(hsp),bbox_bottom-i,block2_top_true,true,true)))
    {
        x+= sign(hsp) 
        y-= i 
        return true
    }
    else 
    if !collision_rectangle(bbox_left+amount*sign(hsp),bbox_top-i,bbox_right+amount*sign(hsp),bbox_bottom-i,block,true,true)
    {
        id_2way_hor = collision_rectangle(bbox_left+amount*sign(hsp),bbox_bottom-5-i,bbox_right+amount*sign(hsp),bbox_bottom-5-i,block2_top_true,true,true)
        if id_2way_hor > 1
        {
            if /*id_2way_hor.state != "top" ||*/ bbox_bottom > id_2way_hor.y+64
            {
                x+= sign(hsp) y-= i 
                return true
            }
        }
    }
}
        
return false