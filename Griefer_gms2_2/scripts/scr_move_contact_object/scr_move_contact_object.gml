obj = argument0
direc = argument1
max_dist = argument2
resolution = argument3  //1 is the highest resolution

x_original = x
y_original = y

for (i=1;i<=max_dist;i+=resolution)
{
    x += trigx(i,direc)
    y += trigy(i,direc)
    if !place_meeting(x,y,obj)
    return true
}

x = x_original
y = y_original
return false