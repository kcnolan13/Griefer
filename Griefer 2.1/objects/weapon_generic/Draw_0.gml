/// @description draw code + trajectories
if !instance_exists(id) exit

if string(varRead("my_player")) = MY_PLAYER_NULL
    draw_sprite_ext(varRead("sprite"),image_index,x,y,image_xscale*WEAPON_SCALE,image_xscale*WEAPON_SCALE,image_angle,image_blend,image_alpha)
    
if not is_string(varRead("my_player"))
{
    printf("WARNING: draw ev weapon_generic: my_player not a string val: "+string(varRead("my_player")))    
}
    
if /*match_starting() or */ match_ending() exit

/*else if varRead("active")
    {
        temp_playah = find_player(varRead("my_player"))
        draw_set_color(c_white)
        draw_set_alpha(1)
        draw_text(x,y-100,objVarRead(temp_playah,"pName"))
    }*/

//trajectories

if not varRead("active") or not varRead("draw_trajectory")
{
    return false
}

//DRAW THE TRAJECTORY
var dir = point_direction(x,y,cursor.x,cursor.y)
var xi = x+trigx(varRead("muzzle_offset"),dir)
var yi = y+trigy(varRead("muzzle_offset"),dir)

if varRead("is_nade") or varRead("charge") > 0
    var spd = varRead("charge")*varRead("bullet_speed")
else
    var spd = varRead("bullet_speed")
    
var grav = varRead("traj_gravity")

if object_index = weapon_torque and varRead("charge") = 1
{
    spd = 20
    grav = 0
}

var rigidity = varRead("traj_rigidity")
var color = varRead("traj_color")
var width = varRead("traj_width")
var resolution = varRead("traj_resolution")
var length = varRead("traj_length")
var highlight = varRead("traj_highlight")
var highlight_interval = varRead("traj_highlight_interval")
var alpha1 = varRead("traj_alpha1")
var alpha2 = varRead("traj_alpha2")
var alpha3 = varRead("traj_alpha3")
var flag = varRead("traj_flag")

draw_trajectory(xi, yi, spd, dir, grav, rigidity, color, width, resolution, length, highlight, highlight_interval, alpha1, alpha2, alpha3, flag)

/* */
/*  */
