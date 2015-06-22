///create_hitscan_flash(flash_obj, x, y, xscale, yscale, angle)
var xpos = argument1
var ypos = argument2
var flash_obj = argument0
var angle = argument5
var xscale = argument3
var yscale = argument4

printf("creating hitscan flash object")
if object_index != bullet_torque
    new_flash = create_muzzle_flash(flash_obj, x, y, angle)
else
    new_flash = create_muzzle_flash(flash_obj, xpos, ypos, angle)
    
objVarWrite(new_flash,"xscale",xscale)
//objVarWrite(new_flash,"yscale",yscale)
//glr_light_set_scaling(new_flash.light,xscale,new_flash.yscale)
//glr_light_set_rotation(new_flash.light,angle)

//send muzzle flash properties to remote players
obj_update_real(new_flash,"angle",FL_NORMAL)
obj_update_real(new_flash,"xscale",FL_NORMAL)
//obj_update_real(new_flash,"yscale",FL_NORMAL)

return new_flash