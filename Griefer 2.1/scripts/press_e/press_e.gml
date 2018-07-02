if not varRead("controllable") return false

 if weapon_switch_delay return false

  if is_bot(id)
    weapon_switch_delay = weapon_switch_delay_max

weapon_wheel_alpha = weapon_wheel_alpha_max
if net_manager.local_player = id
    audio(snd_scroll3,1)
next_weapon()