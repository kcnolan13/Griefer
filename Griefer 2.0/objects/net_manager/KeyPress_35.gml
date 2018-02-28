/// @description bot override

bot_override ^= 1

if instance_exists(local_player)
{
    objVarWrite(local_player,"bot",bot_override)  
    printf("ERROR (not): writing local_player.bot to "+string(bot_override))
}

if keyboard_check(vk_shift)
{
    create_random_users ^= 1
}

