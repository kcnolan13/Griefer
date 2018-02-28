//lobby_leader()
if instance_exists(myPlayer())
{
    if objVarRead(myPlayer(),"pNum") = global.lowest_pnum or net_manager.bot_match
        return true
    else return false
}
return false
