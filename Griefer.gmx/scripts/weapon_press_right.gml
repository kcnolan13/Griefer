//if not varRead("controllable") return false

if mi_jugador < 0 or not objVarRead(mi_jugador,"controllable") return false

mi_jugador = find_player(varRead("my_player"))
var nade_obj = player_nades(mi_jugador)

if nade_obj
{
    if (objVarRead(nade_obj,"clip") or objVarRead(nade_obj,"ammo"))  and not objVarRead(nade_obj,"cant_shoot") and objVarRead(nade_obj,"discharge_delay") < 0
    {
    
        varWrite("quicktoss_timer",varRead("quicktoss_time_between"))
    
        if not objVarRead(nade_obj,"clip")
        {
            objVarSub(nade_obj,"ammo",1)
            objVarAdd(nade_obj,"clip",1)
        }
        
        var num_quicktoss_backcycles = 0;
        if objVarRead(mi_jugador,"weapon0") = objVarRead(mi_jugador,"active_weapon")
        {
            num_quicktoss_backcycles = 3
        } else if objVarRead(mi_jugador,"weapon1") = objVarRead(mi_jugador,"active_weapon")
        {
            num_quicktoss_backcycles = 2
        } else if objVarRead(mi_jugador,"weapon2") = objVarRead(mi_jugador,"active_weapon")
        {
            num_quicktoss_backcycles = 1
        } else num_quicktoss_backcycles = 0
        
        objVarWrite(nade_obj,"quicktoss_backcycles",num_quicktoss_backcycles)
        
        if DEBUG
            printf("QuickTossing. Backcycles needed: "+num_quicktoss_backcycles)
        
        for (var dis_index = 0; dis_index < num_quicktoss_backcycles; dis_index++)
        {
            with (mi_jugador) next_weapon()
        }
        
        //NADE OBJECT IS NOW SUPPOSEDLY THE ACTIVE WEAPON
        
        objVarWrite(nade_obj,"charge",objVarRead(nade_obj,"quicktoss_charge"))
        //trigger a discharge
        objVarWrite(nade_obj,"discharge_delay",objVarRead(nade_obj,"quicktoss_discharge_delay_max"))
        //throwing animation speed
        objVarWrite(mi_jugador,"arm_animation_speed",24/objVarRead(nade_obj,"quicktoss_discharge_delay_max"))
    }
} else {
    if DEBUG
        printf("cannot quicktoss -- NO GRENADES")
}