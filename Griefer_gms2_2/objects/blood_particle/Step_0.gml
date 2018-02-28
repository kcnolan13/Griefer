/// @description all dat ish
counter ++

if alpha < 1
    alpha += 0.125

if trailing
    trailing_counter++
else
    trailing_counter = 0

if counter = 1
{
    grav_original = grav
}

if counter > 1
{
    dir = point_direction(x,y,x+hsp,y+vsp) mod 360
    spd = point_distance(x,y,x+hsp,y+vsp)
}
    
if fade = 1
    intensity /= 1.25

if intensity < 0.0005 or ((instance_number(blood_particle) > 60 and random(60)>59)) or (fps < 25 and random(25) < 2)
{
    instance_destroy() 
    exit
}


if collision_rectangle(bbox_left,bbox_top,bbox_right,bbox_bottom,solid_generic,true,false) or collision_rectangle(bbox_left,bbox_top,bbox_right,bbox_bottom,block2,true,false)
{
    if not trailing
    {
        trailing = true
        if random (10) > 8
            instance_destroy() 
        scr_move_contact_object(solid_generic,dir+180,spd*3,1)
        hsp /= 4; vsp /= 10;
        grav = 0.025
    }
    
    if trailing_counter > trailing_counter_max
    {
        //grav = 0
        //vsp /= 1.125
        instance_destroy()
        exit
    } else {
        vsp += grav
    }

    hsp /= 1.5
    
    if spd < 0.1
    {
        instance_destroy()
        exit
    }
} else
{
    trailing = 0
    grav = grav_original
    vsp += grav
}

x += hsp
y += vsp

if x < 0 or y < 0 or x > room_width or y > room_height
{
    instance_destroy()
    exit
}

