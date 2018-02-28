/// @description flash
event_inherited()

if instance_exists(myFlash)
{
    myFlash.x = x
    myFlash.y = y
    
    if instance_exists(myFlash)
    {
        myFlash.x = x
        myFlash.y = y
        
        if instance_exists(myFlash.light) and instance_exists(dat_jugador)
        {
            bogus_dir = -1*dat_jugador.weapon_rot
            myFlash.light.x = varRead("myX")+trigx(varRead("muzzle_offset"),bogus_dir)
            myFlash.light.y = varRead("myY")+trigy(varRead("muzzle_offset"),bogus_dir)
            myFlash.light.rot = bogus_dir
        }
        
    } else myFlash = noone
    
} else myFlash = noone



