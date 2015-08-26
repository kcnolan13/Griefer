//lobby_leader()
if instance_exists(myPlayer())
{
    if objVarRead(myPlayer(),"pNum") = 0 or net_manager.bot_match
        return true
    else return false
}
return false
