strength = argument0
if standing_2way = false && collision_rectangle(bbox_left,bbox_bottom-strength,bbox_right,bbox_bottom,block2_top_true,true,false)
{
    ID = collision_rectangle(bbox_left,bbox_bottom-strength,bbox_right,bbox_bottom,block2_top_true,true,false)
    if ID.state = "top"
    {
        y_original = y
        for (i=1;i<=strength+5;i++)
        {
            if !collision_rectangle(bbox_left,bbox_bottom-5-i,bbox_right,bbox_bottom-1-i,block2_top_true,true,false)
            {
                y-= i
                return true
            }
        }
    }
}
return false