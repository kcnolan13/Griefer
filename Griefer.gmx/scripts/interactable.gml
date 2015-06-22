interact_obj = argument0

if point_distance(x,y,interact_obj.x,interact_obj.y) < DIST_INTERACT
and (!collision_line(x,y,interact_obj.x,interact_obj.y,block,true,false) or !collision_line(x,y,interact_obj.x,interact_obj.bbox_top,block,true,false) or !collision_line(x,y,interact_obj.x,interact_obj.bbox_bottom,block,true,false))
and (!collision_line(x,y,interact_obj.x,interact_obj.y,block2_top,true,false) or !collision_line(x,y,interact_obj.x,interact_obj.bbox_top,block2_top,true,false) or !collision_line(x,y,interact_obj.x,interact_obj.bbox_bottom,block2_top,true,false))
{
    return true
}
else return false