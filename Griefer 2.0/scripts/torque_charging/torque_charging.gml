/// @description torque_charging()
/// @function torque_charging
var wep = real(varRead("active_weapon"))

if instance_exists(wep)
{
    if string(objVarRead(wep,"name")) = global.torque and real(objVarRead(wep,"charge")) > 0
        return true
}

return false