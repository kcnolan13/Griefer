/// @description find_my_weapon_by_name(wep_name)
/// @function find_my_weapon_by_name
/// @param wep_name
var wep_name = argument0

for (i=0; i<4; i++)
{
    var temp = varRead("weapon"+string(i))        
    if instance_exists(temp)
    {
        if wep_name = objVarRead(temp,"name")
            return temp
    }
}

return false