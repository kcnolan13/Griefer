if not varRead("controllable") or is_bot(id) or time_since_wepcont < 5 return false

if instance_exists(varRead("active_weapon"))
{
    var badWep = varRead("active_weapon")
    if string(objVarRead(badWep,"name")) = global.torque
    {
        if objVarRead(badWep,"charge") > 0
        {
            printf("ERROR: cannot quick switch to pistol ... torque bow is charging")
            return false
        }
    }
}

weapon_wheel_alpha = weapon_wheel_alpha_max

var desired_index = 1
if varRead("weapon_index") = 1
    desired_index = 0

var whiles = 0
while (varRead("weapon_index") != desired_index) and whiles < 1000
{
    whiles++
    if net_manager.local_player = id
        audio(snd_scroll3,1)
    
    if desired_index > varRead("weapon_index")
        next_weapon()
    else
        previous_weapon()
}