///aiming_at_flo(check_distance, xpos, ypos, theta, width, height)
check_distance = argument0
xpos = argument1
ypos = argument2
theta = argument3
width = argument4
height = argument5
resolution = ceil((width + height)/2)

for(i=0;i<=check_distance;i+=resolution)
{
    if collision_rectangle(xpos-width/2+trigx(i,theta),ypos-height/2+trigy(i,theta),xpos+width/2+trigx(i,theta),ypos+height/2+trigy(i,theta),block,true,true) || collision_rectangle(xpos-width/2+trigx(i,theta),ypos-height/2+trigy(i,theta),xpos+width/2+trigx(i,theta),ypos+height/2+trigy(i,theta),solid_generic,true,true)
    return true
}

return false
