///pickup_weapon(weapon_object)
var wep_2pickup = argument0

if torque_charging() return false

varWrite("arm_animation_speed",0)

//printf("picking up weapon: "+wep_2pickup)

var backcycle_counter = 0
var cycle_back_at_end = false

//GET TO THE RIGHT SLOT (depending on what kind of weapon this is)
if objVarRead(wep_2pickup,"is_nade")
{
    cycle_back_at_end = true
    while (varRead("weapon_index") != 3)
    {
        previous_weapon()
        backcycle_counter++
    }
} else if objVarRead(wep_2pickup,"is_secondary")
{
    cycle_back_at_end = false
    while (varRead("weapon_index") != 1)
    {
        previous_weapon()
        backcycle_counter++
    }
} else
{
    cycle_back_at_end = false
    //is there an empty primary slot?
    var empty_slot_num = empty_primary_slot(id)
    if empty_slot_num > -1
        var goto_num = empty_slot_num
    else
    {
        var goto_num = varRead("weapon_index")
        if goto_num != 0 and goto_num != 2
            goto_num = 0
    }
        
    while (varRead("weapon_index") != goto_num)
    {
        previous_weapon()
        backcycle_counter++
    }
}

//drop the weapon that is currently in that slot
drop_weapon(varRead("weapon_index"))

//automatically went to next weapon, so go back again
previous_weapon()

//set weapon #whatever to this obj id
if DEBUG
    printf("setting var weapon"+varRead("weapon_index")+" to "+wep_2pickup)
varWrite("weapon"+string(varRead("weapon_index")),wep_2pickup)

//give your id to the weapon's my_player
if DEBUG
    printf("updating "+objVarRead(wep_2pickup,"uniqueId")+"'s my_player var to "+varRead("uniqueId"))
objVarWrite(wep_2pickup,"my_player",varRead("uniqueId"))

//make sure it wont disappear on you
objVarWrite(wep_2pickup,"disappear_counter",-1)
obj_update_real(wep_2pickup,"disappear_counter",0)

//force-clear the reload and charge counters
objVarWrite(wep_2pickup,"reload_counter",-1)
objVarWrite(wep_2pickup,"reload_empty_counter",-1)
objVarWrite(wep_2pickup,"charge",0)
objVarWrite(wep_2pickup,"charge_counter",-1)
objVarWrite(wep_2pickup,"discharge_delay",-1)
objVarWrite(wep_2pickup,"been_picked_up",true)
obj_update_real(wep_2pickup,"reload_counter",FL_NORMAL)
obj_update_real(wep_2pickup,"reload_empty_counter",FL_NORMAL)
obj_update_real(wep_2pickup,"charge",FL_NORMAL)
obj_update_real(wep_2pickup,"charge_counter",FL_NORMAL)
obj_update_real(wep_2pickup,"discharge_delay",FL_NORMAL)
obj_update_real(wep_2pickup,"been_picked_up",FL_NORMAL)

if DEBUG
    printf("sending the weapon's my_player var (my uniqueId = "+objVarRead(wep_2pickup,"my_player")+")")
obj_update_real(wep_2pickup,"my_player",0)

//pull this in as the new active weapon
if DEBUG
    printf("syncing active weapon...")
sync_active_weapon()

if DEBUG
    printf("picked up weapon: "+objVarRead(wep_2pickup,"uniqueId")+" : "+objVarRead(wep_2pickup,"name"))

//return to the weapon you were on before if you picked up grenades or a sidearm
if cycle_back_at_end
{
    while (backcycle_counter)
    {
        next_weapon()
        backcycle_counter --
    }
}
