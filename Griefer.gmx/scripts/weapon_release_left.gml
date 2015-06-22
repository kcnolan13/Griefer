//if not varRead("controllable") return false

mi_jugador = find_player(varRead("my_player"))

if varRead("active") and varRead("reload_counter") < 0 and objVarRead(mi_jugador,"controllable") and varRead("clip") >= varRead("clip_decrement") and not varRead("cant_shoot") and varRead("control_type") = "left_charge" and varRead("charge_counter") > -1
{
    if object_index != weapon_torque
    {
        //trigger a discharge
        varWrite("discharge_delay",varRead("discharge_delay_max"))
        //throwing animation speed
        objVarWrite(mi_jugador,"arm_animation_speed",24/varRead("discharge_delay_max"))
    } else weapon_discharge()
}