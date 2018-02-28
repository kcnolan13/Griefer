/// @description quickselect_secondary()
/// @function quickselect_secondary
if not varRead("controllable") or is_bot(id) exit

if torque_charging() return false

weapon_wheel_alpha = weapon_wheel_alpha_max
var attempts = 0
while (varRead("weapon_index") != 2 and attempts < 20)
{
attempts++
if net_manager.local_player = id
    audio(snd_scroll3,1)
    next_weapon()
}