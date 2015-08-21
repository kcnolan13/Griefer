var num = argument0
var wep_2drop = varRead("weapon"+string(num))

if torque_charging() return false

force_switch = true

varWrite("arm_animation_speed",0)

if DEBUG
    printf("dropping weapon number "+num+", which is: "+varRead("weapon"+string(num)))

if instance_exists(wep_2drop)
{
    varWrite("weapon"+string(num),NO_HANDLE)
    
    next_weapon()
    
    objVarWrite(wep_2drop,"active",false)
    if not is_bot(id)
        wep_2drop.myCursor.active = false
    
    if objVarRead(wep_2drop,"can_disappear")
        objVarWrite(wep_2drop,"disappear_counter",objVarRead(wep_2drop,"disappear_delay"))
        
    objVarWrite(wep_2drop,"my_player",NO_HANDLE)
    objVarWrite(wep_2drop,"my_player_name","")
    
    obj_update_real(wep_2drop,"disappear_counter",FL_NORMAL)
    obj_update_real(wep_2drop,"my_player",FL_NORMAL)
    obj_update_string(wep_2drop,"my_player_name",FL_NORMAL)
    obj_update_real(wep_2drop,"active",FL_NORMAL)
    
    force_switch = false
    return true
    
} else 
{
    if DEBUG
        printf("tried to drop nonexistent weapon")
    next_weapon()
    force_switch = false
    return false
}
