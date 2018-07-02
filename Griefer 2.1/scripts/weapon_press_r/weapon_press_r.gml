mi_jugador = find_player(varRead("my_player"))
if varRead("active") and mi_jugador > -1 and varRead("reload_counter") < 0 and varRead("ammo") > 0 and varRead("clip") < varRead("clip_cap")
{
    trigger_reload()
}