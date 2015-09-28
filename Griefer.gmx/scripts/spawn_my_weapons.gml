//protect against multiple weapon spawns --> make sure all slots are empty
if varRead("weapon0") >= 0 or varRead("weapon1") >= 0 or varRead("weapon2") >= 0 or varRead("weapon3") >= 0
{
    printf("ERROR: tried to spawn starting weapons multiple times")
    sync_active_weapon()
    return false
}

force_switch = true

varWrite("weapon_index",0)

dat_wep_do = instance_create_for_everyone(x,y,weapon_shotgun)
pickup_weapon(dat_wep_do)
next_weapon()

if not instance_exists(dat_wep_do)
{
    printf("ERROR: "=string(dat_wep_do)+" no longer exists! helllp in spawn my weapons!")
}

dat_wep_do = instance_create_for_everyone(x,y,weapon_pistol)
pickup_weapon(dat_wep_do)
next_weapon()

if not instance_exists(dat_wep_do)
{
    printf("ERROR: "=string(dat_wep_do)+" no longer exists! helllp in spawn my weapons!")
}

dat_wep_do = instance_create_for_everyone(x,y,weapon_rifle)
pickup_weapon(dat_wep_do)
next_weapon()

if not instance_exists(dat_wep_do)
{
    printf("ERROR: "=string(dat_wep_do)+" no longer exists! helllp in spawn my weapons!")
}

dat_wep_do = instance_create_for_everyone(x,y,weapon_flashbang)
pickup_weapon(dat_wep_do)
objVarWrite(dat_wep_do,"ammo",0)
next_weapon()

if not instance_exists(dat_wep_do)
{
    printf("ERROR: "=string(dat_wep_do)+" no longer exists! helllp in spawn my weapons!")
}

force_switch = false

return true
