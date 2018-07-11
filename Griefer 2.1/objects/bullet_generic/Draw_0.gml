/// @description draw sprite + direction + trajectory (maybe)
/// @function draw sprite + direction + trajectory 
/// @param maybe

if no_from_player
{
    printf("ERROR: cannot draw bullet_generic -- no_from_player")
    exit
}

if traj_draw
    image_blend = traj_color

draw_sprite_ext(varRead("sprite"),image_index,x,y,image_xscale,image_yscale,image_angle,image_blend,image_alpha)

if traj_draw and (varRead("local") or counter > 1)
{
    var dat_length = min(point_distance(varRead("myX"),varRead("myY"),varRead("startX"),varRead("startY")),traj_length)
    traj_xscale = dat_length/300
    ///draw a simple line
    draw_set_color(traj_color)
    draw_set_alpha(traj_intensity)
    if traj_sprite = spr_none
        draw_line_width(x,y,x+trigx(-300*traj_xscale,varRead("direction")),y+trigy(-300*traj_xscale,varRead("direction")),traj_yscale)
    else
        draw_sprite_ext(traj_sprite,0,x,y,traj_xscale,traj_yscale,(varRead("direction")+180) mod 360,traj_color,traj_intensity)
    draw_set_alpha(1)
    draw_set_color(c_white)
}

