///assume_weapon(weapon_obj_index)
var weapon_obj_index = argument0

{
    var ID = instance_create(-64,-64,weapon_obj_index)
    varWrite("active_weapon_sprite",objVarRead(ID,"sprite"))
    varWrite("arm_pose",objVarRead(weapon_obj_index,"pose"))
    varWrite("active_weapon_prescaler",objVarRead(ID,"scale"))
    with ID instance_destroy()
}