/// @description find_player(uniqueId)
/// @function find_player
/// @param uniqueId
uId = argument0
for (i=0; i<instance_number(player); i++)
{
    ID = instance_find(player,i)
    if string(objVarRead(ID,"uniqueId")) = string(uId)
        return ID.id
}

//printf("::: WARNING: find_player could not find player :"+string(pNum))
return NO_HANDLE
