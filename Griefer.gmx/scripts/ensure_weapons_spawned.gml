//protect against multiple weapon spawns --> make sure all slots are empty
var cur_index = varRead("weapon_index")

if instance_exists(varRead("active_weapon"))
    objVarWrite(varRead("active_weapon"),"active",false)

if not instance_exists(varRead("weapon0"))
{
    varWrite("weapon_index",0)
    dat_wep_do = instance_create_for_everyone(x,y,weapon_rifle)
    pickup_weapon(dat_wep_do)
    objVarWrite(dat_wep_do,"active",false)
    printf("::: "+playerName(id)+" RESPAWNING RIFLE (failed on first attempt)")
}

if not instance_exists(varRead("weapon1"))
{
    varWrite("weapon_index",1)
    dat_wep_do = instance_create_for_everyone(x,y,weapon_pistol)
    pickup_weapon(dat_wep_do)
    objVarWrite(dat_wep_do,"active",false)
    printf("::: "+playerName(id)+" RESPAWNING PISTOL (failed on first attempt)")
}

if not instance_exists(varRead("weapon2"))
{
    varWrite("weapon_index",2)
    dat_wep_do = instance_create_for_everyone(x,y,weapon_shotgun)
    pickup_weapon(dat_wep_do)
    objVarWrite(dat_wep_do,"active",false)
    printf("::: "+playerName(id)+" RESPAWNING SHOTGUN (failed on first attempt)")
}

if not instance_exists(varRead("weapon3"))
{
    varWrite("weapon_index",3)
    dat_wep_do = instance_create_for_everyone(x,y,weapon_flashbang)
    pickup_weapon(dat_wep_do)
    objVarWrite(dat_wep_do,"active",false)
    printf("::: "+playerName(id)+" RESPAWNING FRAG (failed on first attempt)")
}

varWrite("weapon_index",cur_index)
sync_active_weapon()

return true
