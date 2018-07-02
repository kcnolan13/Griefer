/// @description bot_lose_gear(gear_sprite)
/// @function bot_lose_gear
/// @param gear_sprite
var gear_sprite = argument0

printf("BOT GEAR LOSS TRIGGER for "+varRead("pName")+": sprite_index = "+string(gear_sprite))
var limb_type = bpart_lookup(gear_sprite,global.BPART_LIMB_TYPE)

if net_manager.steal_mode = GEAR_STEAL
{
    //replace this limb with the default gear
    varWrite(limb_type+"0",default_limb_of_type(limb_type))
    printf("    .."+varRead("pName")+" lost gear! now "+string(limb_type)+"0 = "+string(get_bpart_list_index(limb_type)))
    varWrite("gear_to_lose",false)
}
else
{
    varWrite("gear_to_lose",false)
}