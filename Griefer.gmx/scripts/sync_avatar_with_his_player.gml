///sync_avatar_with_his_player(avatar_object)
var av = argument0

for (i=0; i<instance_number(player); i++)
{
    var playah = instance_find(player,i)
    if objVarRead(playah,"pName") = objVarRead(av,"pName")
    {
        //sync up all their shit and be done with it
        for (var j=0; j<8; j++)
        {
            var str = global.bpart_limb_types[j]+"0"
            objVarWrite(av,str,objVarRead(playah,str))
            printf(objVarRead(av,"pName")+"'s avatar limb sprites synchronized with his player's")
            return true
        }
    }

}
return false