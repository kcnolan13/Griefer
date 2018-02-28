/// @description bot rank down
if varRead("bot")
{
    varSub("rank",1)
    var av = find_pname_avatar(playerName(id))
    if instance_exists(av)
    {
        objVarSub(av,"rank",1)
    }
}

exit;
