/// @description drop_weapon_position(weapon_num, drop_x, drop_y)
/// @function drop_weapon_position
/// @param weapon_num
/// @param  drop_x
/// @param  drop_y
var num = argument0
var wep_2drop = varRead("weapon"+string(num))
var drop_x = argument1
var drop_y = argument2

if torque_charging() return false

if instance_exists(wep_2drop)
{

    if DEBUG
        printf("DROPPING "+objVarRead(wep_2drop,"name")+" at "+drop_x+", "+drop_y)

    wep_2drop.x = drop_x
    wep_2drop.y = drop_y
    objVarWrite(wep_2drop,"myX",drop_x)
    objVarWrite(wep_2drop,"myY",drop_y)
    obj_update_real(wep_2drop,"myX",FL_NORMAL)
    obj_update_real(wep_2drop,"myY",FL_NORMAL)
    
    if drop_weapon(num)
        return true
    else
    {
        if DEBUG
            printf("ERROR: failed to drop the weapon")
            
         return false
    }
}
else return false