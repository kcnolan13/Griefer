/// @description flash
event_inherited()

if instance_exists(myFlash)
{
    myFlash.x = x
    myFlash.y = y
    
    if instance_exists(myFlash.light)
    {
        myFlash.light.x = x
        myFlash.light.y = y
    }
    
} else myFlash = noone




