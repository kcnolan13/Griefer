/// @description flash
if instance_exists(myFlash)
{
    myFlash.x = x
    myFlash.y = y
    
    if instance_exists(myFlash.light)
    {
        myFlash.light.x = x
        myFlash.light.y = y
        myFlash.light.rot = point_direction(xprevious,yprevious,x,y)
    }
    
} else myFlash = noone

if myFlash = noone
{
    noflash_counter ++
    
    if noflash_counter > 30/5
    {
        myFlash = instance_create(x,y,flash_torque)
        objVarWrite(myFlash,"angle",1)
        noflash_counter = 0
    }
}


event_inherited()

if varRead("local")
{
    obj_update_real(id,"myX",FL_NORMAL)
    obj_update_real(id,"myY",FL_NORMAL)
    obj_update_real(id,"hitscan",FL_NORMAL)
    varWrite("dir_override",dir_perm)
    obj_update_real(id,"dir_override",FL_NORMAL)
}



