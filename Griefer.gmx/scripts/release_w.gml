if not varRead("controllable") return false


if redirect_counter = 0
varWrite("animation_speed",0)

if vsp/1.5 < -5 && jumping = true
{vsp /= 1.5 jumping = false}
else if jumping = true
{if vsp < -5 vsp = -5 jumping = false}
