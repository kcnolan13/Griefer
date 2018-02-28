/// @description basic physics, rotation, bleeding, etc
scr_basic_physics()

counter++

if instance_number(limb_generic) > global.limb_limit and random(3*global.limb_limit) < 1
{
    instance_destroy()
    exit
}

//update blood streamer
if instance_exists(blood_streamer)
{
    blood_streamer.x = x
    blood_streamer.y = y
    blood_streamer.dir = fakedirection
}

if !collision_rectangle(bbox_left+5,bbox_top,bbox_right-5,bbox_bottom+32,block,true,false) && standing_2way = false and counter < 30*2
{
    fakedirection += rspeed*sign(rotation)
}
else
{
    if bleeding >0
    bleeding -=1
}

if bleeding <= 0
{
    image_alpha -= 0.05
    if (image_alpha < 0.05)
        instance_destroy()
}

x = varRead("myX")
y = varRead("myY")
//printf("I'm alive! at "+x+", "+y)

