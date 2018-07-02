/// @description bot_lose_gear(gear_sprite)
/// @function bot_lose_gear
/// @param gear_sprite
var gear_sprite = argument0

printf("BOT GEAR STEAL TRIGGER for "+varRead("pName")+": sprite_index = "+string(gear_sprite))
var limb_type = bpart_lookup(gear_sprite,global.BPART_LIMB_TYPE)

//replace this limb with the default gear
varWrite(limb_type+"0",gear_sprite)
printf("    .."+varRead("pName")+" stole gear! now "+limb_type+"0 = "+string(gear_sprite))
varWrite("gear_to_steal",false)