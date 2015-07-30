///spray_blood(x, y, mag, dir, dir_variance, time, gravity, speed, speed_variance, xy_variance,col)
var xi = argument0
var yi = argument1
var mag = argument2
var dir = argument3
var dir_var = argument4
var time = argument5
var grav = argument6
var spd = argument7
var spd_var = argument8
var xy_var = argument9
var col = argument10


if not truthval(global.gc[GC_VIOLENT_CONTENT,1])
{
    return noone
}

ID = instance_create(xi,yi,blood_splosion)
if ID != noone
{
    ID.x = xi
    ID.y = yi
    ID.size = mag
    ID.time = time
    ID.dir = dir
    ID.dir_variance = dir_var
    ID.grav = grav
    ID.spd = spd
    ID.spd_variance = spd_var
    ID.xy_variance = xy_var
    ID.blood_color = col
    return ID
} else {
    printf("ERROR: blood_splosion ID is noone for some reason")
    return noone
}