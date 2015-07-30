//deactivate current weapon
if DEBUG
    printf("next weapon")
    
if torque_charging() return false

varWrite("arm_animation_speed",0)

 if not force_switch and weapon_switch_delay and alive_counter > room_speed*3 and (instance_exists(varRead("active_weapon")) and objVarRead(varRead("active_weapon"),"ammo") > 0)
    return false

if instance_exists(varRead("active_weapon"))
{
    objVarWrite(varRead("active_weapon"),"active",false)
    wep = varRead("active_weapon")
    if not is_bot(id)
    wep.myCursor.active = false
}

varAdd("weapon_index",1)
if varRead("weapon_index") > 3
    varWrite("weapon_index",0)

sync_active_weapon()
