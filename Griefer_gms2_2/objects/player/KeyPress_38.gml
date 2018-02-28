/// @description bot rank up
if varRead("bot")
{
    varAdd("rank",1)
    var av = find_pname_avatar(playerName(id))
    if instance_exists(av)
    {
        objVarAdd(av,"rank",1)
    }
}

exit;
