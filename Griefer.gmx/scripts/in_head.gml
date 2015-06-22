projectile = argument0

if collision_rectangle(bbox_left,bbox_top-7,bbox_right,bbox_top+(bbox_bottom-bbox_top)/6,projectile,false,false)
{
    return true
}
else return false