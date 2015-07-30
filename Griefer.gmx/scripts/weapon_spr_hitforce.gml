///weapon_spr_hitforce(weapon_sprite)
var spr = argument0

if spr <= spr_weapon_placeholder1 or spr >= spr_weapon_placeholder2
{
    printf("ERROR: weapon_spr_hitforce passed a bad weapon_sprite!")
    return FORCE_NONE
}

if spr < spr_no_hitforce
    return FORCE_NONE
else if spr < spr_minor_hitforce    
    return FORCE_MINOR
else if spr < spr_major_hitforce
    return FORCE_MAJOR
else if spr < spr_redonk_hitforce
    return FORCE_REDONK
    