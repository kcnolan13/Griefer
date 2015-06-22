///is_bot(potential_bot_obj)
var pot_bot = argument0

if not instance_exists(pot_bot)
{
    printf("ERROR: is_bot(): passed nonexistent obj")
    return false
}

if pot_bot.object_index != avatar and pot_bot.object_index != player
    return false

if objVarRead(pot_bot,"bot")
{
    if SUPER_DEBUG
        printf(objVarRead(pot_bot,"pName")+" is a bot!")
    return true
}
else
    return false