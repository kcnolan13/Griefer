//if not varRead("controllable") return false

mi_jugador = find_player(varRead("my_player"))

if varRead("active") and varRead("reload_counter") < 0 and objVarRead(mi_jugador,"controllable") and not varRead("cant_shoot") and varRead("clip") >= varRead("clip_decrement")
{
    if varRead("control_type") = "left_hold"
        weapon_shoot()
    else if varRead("control_type") = "left_charge"
        weapon_charge()
}