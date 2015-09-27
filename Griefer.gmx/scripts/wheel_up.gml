if not varRead("controllable") return false

if varRead("controllable") and not mouse_wheel_delay
{

     if weapon_switch_delay return false
    
      if is_bot(id)
        weapon_switch_delay = weapon_switch_delay_max

    mouse_wheel_delay = mouse_wheel_delay_max
    weapon_wheel_alpha = weapon_wheel_alpha_max
    if net_manager.local_player = id
    audio(snd_scroll3,1)
    previous_weapon()
}