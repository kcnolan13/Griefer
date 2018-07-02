/// @description constrict_physics_speed(max_speed,max_vang)
/// @function constrict_physics_speed
/// @param max_speed
/// @param max_vang
var spd = argument0
var vang = argument1

if phy_speed > spd
{
    var speed_ang = point_direction(0,0,phy_speed_x,phy_speed_y)
    phy_speed_x = trigx(spd,speed_ang)
    phy_speed_y = trigy(spd,speed_ang)
}
if phy_angular_velocity > vang
    phy_angular_velocity = vang