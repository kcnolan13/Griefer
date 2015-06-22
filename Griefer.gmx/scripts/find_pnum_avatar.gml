///find_pnum_avatar(uniqueId)
var pnum = argument0

for (var i=0; i<instance_number(avatar); i++)
{
    var ID = instance_find(avatar,i)
    if objVarRead(ID, "uniqueId") = varRead("uniqueId")
        return ID
}
return noone