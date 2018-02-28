//if not varRead("controllable") return false

mi_jugador = find_player(varRead("my_player"))

if varRead("active") and varRead("reload_counter") < 0 and objVarRead(mi_jugador,"controllable") and varRead("clip") >= varRead("clip_decrement") and not varRead("cant_shoot") and varRead("control_type") = "left_press"
{
    weapon_shoot()
}