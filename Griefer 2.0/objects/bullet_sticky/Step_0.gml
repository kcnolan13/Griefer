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

if myFlash = noone and (stuck or spd < 3)
{
    noflash_counter ++
    
    if noflash_counter > 30/5
    {
        myFlash = instance_create(x,y,flash_sticky)
        objVarWrite(myFlash,"angle",1)
        noflash_counter = 0
    }
}


