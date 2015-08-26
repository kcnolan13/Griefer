///find_player(uniqueId)
uId = argument0
for (i=0; i<instance_number(player); i++)
{
    ID = instance_find(player,i)
    if string(objVarRead(ID,"uniqueId")) = string(uId)
        return ID
}

//printf("::: WARNING: find_player could not find player :"+string(pNum))
return NO_HANDLE
