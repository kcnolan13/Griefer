/// @description sync active weapon()
/// @function sync active weapon
//printf("setting active_weapon to "+varRead("weapon"+varRead("weapon_index")))
varWrite("active_weapon",varRead("weapon"+string(varRead("weapon_index"))))

//sync the active weapon sprite
if instance_exists(varRead("active_weapon"))
{
    varWrite("active_weapon_sprite",objVarRead(varRead("active_weapon"),"sprite"))
    varWrite("active_weapon_prescaler",objVarRead(varRead("active_weapon"),"scale"))
    //activate the current weapon
    objVarWrite(varRead("active_weapon"),"active",true)
    varWrite("arm_pose",objVarRead(varRead("active_weapon"),"pose"))
    return true
}
else
{
    varWrite("active_weapon_sprite",spr_none)
    varWrite("active_weapon_prescaler",1)
    return false
}