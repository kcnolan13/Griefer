/// @description absorb_weapon(weapon_object)
/// @function absorb_weapon
/// @param weapon_object
//TO BE CALLED FROM A PLAYER
var wep_2absorb = argument0

//find your weapon that this will be absorbed into
var my_wep = find_my_weapon_by_name(objVarRead(wep_2absorb,"name"))

if not my_wep
{
    printf("ERROR: failed to absorb weapon -- you don't have one by this name")
    return false
}

objVarAdd(my_wep,"ammo",objVarRead(wep_2absorb,"clip")+objVarRead(wep_2absorb,"ammo"))

if objVarRead(wep_2absorb,"spawner") > -1
{
    if DEBUG
        printf("preparing to absorb --> overriding current spawner id with new one")

    objVarWrite(my_wep,"spawner",objVarRead(wep_2absorb,"spawner"))
    obj_update_real(my_wep,"spawner",FL_NORMAL)
}

//ammo overflow
if objVarRead(my_wep,"ammo") > objVarRead(my_wep,"max_ammo")
{
    //if DEBUG
        printf("capping off ammo overflow (caused by weapon absorption)...")
        
    objVarWrite(my_wep,"ammo",objVarRead(my_wep,"max_ammo"))
}

printf("::: absorbed weapon: "+string(wep_2absorb)+" : "+objVarRead(wep_2absorb,"name"))

if net_manager.local_player = id
    audio(snd_pickup2,1)

instance_destroy_for_everyone(wep_2absorb)
with (wep_2absorb) {exit}
