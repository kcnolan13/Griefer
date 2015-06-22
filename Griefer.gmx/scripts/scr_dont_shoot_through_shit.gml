//don't shoot through shit
if other.id.object_index != bolt 
&& (collision_line(other.id.x,other.id.y,x,y,block,true,true) && collision_line(other.id.x,other.id.y,bbox_left,y,block,true,true) && collision_line(other.id.x,other.id.y,bbox_right,y,block,true,true) && collision_line(other.id.x,other.id.y,x,bbox_top,block,true,true) && collision_line(other.id.x,other.id.y,x,bbox_bottom,block,true,true))
|| (collision_line(other.id.x,other.id.y,x,y,block2_top,true,true) && collision_line(other.id.x,other.id.y,bbox_left,y,block2_top,true,true) && collision_line(other.id.x,other.id.y,bbox_right,y,block2_top,true,true) && collision_line(other.id.x,other.id.y,x,bbox_top,block2_top,true,true) && collision_line(other.id.x,other.id.y,x,bbox_bottom,block2_top,true,true))
{
    with (other.id)
    instance_destroy()
    exit
}