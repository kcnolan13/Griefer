///find_pname_avatar(player_name)
var pname = argument0

for (var i=0; i<instance_number(avatar); i++)
{
    ID = instance_find(avatar,i)
    if string(objVarRead(ID, "pName")) = pname
    {
        if DEBUG
            printf("found the desired avatar: "+string(objVarRead(ID, "pName")))
        return ID
    }
}
return noone