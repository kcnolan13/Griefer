//deactivate current weapon
if DEBUG
 printf("previous weapon")
 
 if torque_charging() return false
 
 if not force_switch and weapon_switch_delay and alive_counter > 30*3
    return false
 
varWrite("arm_animation_speed",0)

if instance_exists(varRead("active_weapon"))
{
    objVarWrite(varRead("active_weapon"),"active",false)
    wep = varRead("active_weapon")
    if not is_bot(id)
        wep.myCursor.active = false
}

//adjust weapon index
varSub("weapon_index",1)
if varRead("weapon_index") < 0
    varWrite("weapon_index",3)

sync_active_weapon()
