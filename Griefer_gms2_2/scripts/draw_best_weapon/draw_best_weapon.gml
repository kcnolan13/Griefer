/// @description draw_best_weapon(range, percent_active)
/// @function draw_best_weapon
/// @param range
/// @param  percent_active
var range = argument0
var percent_active = argument1
var prob_switch_if_reloading = percent_active
var switch_if_reloading = false

if range < 64*6 and random(1) < prob_switch_if_reloading
    switch_if_reloading = true
    
//printf("::: "+playerName(id)+" DRAWING BEST WEAPON")

var final_slot_index = 0
var best_weapon = NO_HANDLE
var lethality = 0
var range_trump = false
var closest_range = 99999999    //range closest to desired range for weapon

for (var i=0; i<4; i++)
{
    var wep = varRead("weapon"+string(i))
    if instance_exists(wep)
    {
        //exclude this as an option if no ammo or reloading (sometimes)
        if objVarRead(wep,"ammo") < 1 and objVarRead(wep,"clip") < 1
        {
            continue
        }
        
        if objVarRead(wep,"clip") < 1 and switch_if_reloading
        {
            printf("::: auto-switched to a weapon with clip -- too close for comfort")
            continue
        }
    
        if objVarRead(wep,"lethality") > lethality and not range_trump
        {
            //lethality trump situation -- overrides when lethality rated higher than previous trump
            final_slot_index = i
            best_weapon = wep
            printf("::: "+objVarRead(wep,"name")+" : lethality goes from "+string(lethality)+" ---> "+string(objVarRead(wep,"lethality")))
            lethality = objVarRead(wep,"lethality")
        }
        
        if objVarRead(wep,"range_trump")                                                         //is a range trump situation
        and abs(range - objVarRead(wep,"range_rating")) < objVarRead(wep,"range_trump_distance") //within trump distance of rated range
        and (not range_trump or objVarRead(wep,"lethality")+objVarRead(wep,"range_trump_extra_lethality") > lethality)                         //override previous range trumps if more lethal
        {
            printf("::: "+objVarRead(wep,"name")+" [range trump] : lethality goes from "+string(lethality)+" ---> "+ string(objVarRead(wep,"lethality") + objVarRead(wep,"range_trump_extra_lethality")) )
            final_slot_index = i
            best_weapon = wep
            range_trump = true
            lethality = objVarRead(wep,"lethality") + objVarRead(wep,"range_trump_extra_lethality")
        }
    }
}

if instance_exists(best_weapon)
{
    //printf("::: chose slot "+string(final_slot_index)+", weapon: "+objVarRead(best_weapon,"name")+", range_trump = "+string(range_trump)+", lethality = "+string(lethality))
}
else
{
    printf(":::WARNING: "+playerName(id)+" unable to find a best weapon to select")
}

if random(1) < (0.025/percent_active)
{
    //pick a random weapon
    final_slot_index = floor(random_range(0,3.99))
}

final_slot_index = constrict(final_slot_index, 0, 3)
varWrite("weapon_index",final_slot_index)
sync_active_weapon()

//if instance_exists(varRead("active_weapon"))
  //  printf("::: active weapon is now: "+string(objVarRead(varRead("active_weapon"),"name")))
    
return true
