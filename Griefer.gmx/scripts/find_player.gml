///find_player(pNum)
pNum = argument0
for (i=0; i<instance_number(player); i++)
{
    ID = instance_find(player,i)
    if real(objVarRead(ID,"uniqueId") = real(pNum)) or (object_index = weapon_generic and playerName(ID) = varRead("my_player_name"))
        return ID
}

//printf("::: WARNING: find_player could not find player :"+string(pNum))
return NO_HANDLE
