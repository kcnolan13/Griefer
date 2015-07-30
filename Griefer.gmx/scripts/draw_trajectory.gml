///draw_trajectory(x, y, speed, direction, gravity, rigidity, color, width, resolution, length, highlight, highlight_interval, alpha1, alpha2, alpha3, flag)

if SUPER_DEBUG
    printf("starting trajectory draw")

var xi = argument0
var yi = argument1
var spd = argument2
var dir = argument3
var grav = argument4
var rigidity = argument5
var color = argument6
var width = argument7
var resolution = argument8
var length = argument9
var highlight = argument10
var highlight_interval = argument11
var alpha1 = argument12
var alpha2 = argument13
var alpha3 = argument14
var flag = argument15

var dist = 0
var xbefore = xi
var ybefore = yi
var xnow = xi
var ynow = yi
var num_highlights = 0
var num_segments = 0
var alpha = alpha1

var xspd = trigx(spd,dir)
var yspd = trigy(spd,dir)

var bail = false

if flag = FL_BOUNCE or flag = FL_BULLET
    col_obj = solid_generic
else
    col_obj = solid_generic//shootable_generic
    
draw_set_color(color)

var traj_bounces = 0
var whiles = 0
while (dist < length and not bail) and whiles < 10000
{
    whiles++
    xi = xnow
    yi = ynow
    
    //if we've traveled far enough along the path, draw a highlight
    if dist > num_highlights*(1+highlight_interval) and num_segments%resolution = 0
    {
        num_highlights++
        draw_sprite_ext(highlight, -1, xnow, ynow, 1, 1, 0, color, alpha)
    }
        
    //COMPUTE THE NEXT COORDINATE PAIR
    
    //mimic tossable generic's physics
    yspd += grav
    
    //recompute speed and direction
    spd = point_distance(xnow, ynow, xnow+xspd, ynow+yspd)
    dir = point_direction(xnow, ynow, xnow+xspd, ynow+yspd)
    
    if spd < 0.1 
        bail = true
    
    var inst = noone
    
    if object_index != weapon_torque
        inst = collision_line_first(xnow, ynow, xnow+xspd, ynow+yspd, col_obj, true,true)
    else inst = hitscan_targets(xnow,ynow,xnow+xspd,ynow+yspd,shootable_generic,true,false,dat_jugador)
        
    
    if inst != noone
    {
        xnow = collision_x
        ynow = collision_y
        
        if flag = FL_DISAPPEAR and (object_index != weapon_torque or traj_bounces > 0 or inst.object_index = player)
            bail = true
        else //if flag = FL_BOUNCE 
        {
            //only bounce if there's enough speed
            if spd > BOUNCE_MINSPEED
            {
                traj_bounces ++
                //unstick from blocks
                unstick_in_direction(xnow, ynow, dir+180, spr_tossable_generic, 64*5, 2)
                //scr_unstick_tossable_trajectory(spr_tossable_generic)
                //draw_sprite(spr_hit_marker,-1,xnow,ynow)
                //bounce off the object
                var normal = scr_normal_detect(xnow,ynow,col_obj,sprite_get_width(spr_tossable_generic)/4,1)
                var new_dir = (normal + (normal - (dir+180))) mod 360
                
                //update some vars
                xspd = trigx(spd/rigidity,new_dir)
                yspd = trigy(spd/rigidity,new_dir)
                
                //recompute speed and direction
                spd = point_distance(xnow, ynow, xnow+xspd, ynow+yspd)
                dir = point_direction(xnow, ynow, xnow+xspd, ynow+yspd)
                
            }
            else
            {
                //not enough speed to bounce
                xspd = 0
                yspd = 0
                spd = 0
                grav = 0
                bail = true
            }
        }   
    } else {
        //nothing was in the way --> compute xnow and ynow normally
        xnow = xi+xspd
        ynow = yi+yspd
    }
    
    //compute new distance traveled
    
    num_segments++
    
    //NOW DRAW THE SEGMENT
    if num_segments%resolution = 0
    {
        //compute segment alpha
        if dist < length/2
            alpha = alpha1 - dist/(length/2)*(alpha1-alpha2)
        else
            alpha = alpha2 - (length/2-dist)/(length/2)*(alpha3-alpha2)

        draw_set_alpha(alpha)
        
        //draw the actual line segment
        //printf("xbefore="+xbefore+", ybefore="+ybefore+", xnow="+xnow+", ynow="+ynow+", alpha="+alpha+", visible="+visible)
        draw_line_width(xbefore, ybefore, xnow, ynow, width)
        xbefore = xnow
        ybefore = ynow
    }
    
    dist += point_distance(xi, yi, xnow, ynow)
    
}

//printf("done drawing trajectory: "+num_segments+" segments drawn!")
return true