///master_of(player_obj_who_might_be_bot)
var bot_maybe = argument0
if objVarRead(bot_maybe,"bot")
{
    if instance_exists(net_manager.local_player)
    {
        return true
    }
    else
    {
        printf("ERROR: cant check if bot, no local player")
        return false
    }
}
else
{
    if SUPER_DEBUG
        printf("not master --> this is not even a bot")
    
    return false
}
