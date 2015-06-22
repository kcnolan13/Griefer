///create_muzzle_flash(flash_obj, x, y, angle)
var xpos = argument1
var ypos = argument2
var flash_obj = argument0
var angle = argument3

var new_flash = instance_create_for_everyone(xpos,ypos,flash_obj)
objVarWrite(new_flash,"angle",angle)
//new_flash.enabled = true
//glr_light_set_active(new_flash.light,true)
//glr_light_set_rotation(new_flash.light,angle)
//glr_light_set_intensity(new_flash.light,new_flash.intensity)

//send muzzle flash properties to remote players
obj_update_real(new_flash,"angle",FL_NORMAL)

if new_flash.object_index != flash_none
{
    with new_flash
        glr_lightsimple_set_rotation(light,varRead("angle"))
}

return new_flash