///bullet_in_head(projectile, headshot_difficulty)
projectile = argument0
difficulty = argument1

if collision_rectangle(bbox_left,bbox_top-7+difficulty,bbox_right,bbox_top+(bbox_bottom-bbox_top)/(6*difficulty),projectile,false,false)
{
    return true
}
else return false