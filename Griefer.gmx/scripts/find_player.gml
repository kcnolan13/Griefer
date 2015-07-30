///find_player(pNum)
pNum = argument0
for (i=0; i<instance_number(player); i++)
{
    ID = instance_find(player,i)
    if real(objVarRead(ID,"uniqueId") = real(pNum))
    //if (real(objVarRead(ID,"pNum")) = real(pNum))
        return ID
}

return NO_HANDLE