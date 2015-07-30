///gravatar_wipe(gravatar_obj)
var grav = argument0

if not instance_exists(grav)
{
    printf("ERROR: gravatar_wipe has been passed nonexistent gravatr")
    return false
}   

if grav = net_manager.stat_gravatar
{
    stat_manager.grav_ready = false
}

with grav
{
    bparts_all_init()
    bparts_ready[0] = false
    bparts_ready[1] = false
    bparts_ready[2] = false
    bparts_ready[3] = false
    bparts_ready[4] = false
    bparts_ready[5] = false
    bparts_ready[6] = false
    bparts_ready[7] = false
    bparts_ready[8] = false
    bparts_ready[9] = false
    bparts_done_ready = false
    wep_index = ceil(random_range(weapon_placeholder1+1,weapon_placeholder2-1))
    assume_weapon(wep_index)
    animation_stand()
    varWrite("visible",false)
    varWrite("animation_speed",SPD_STAND)
}