/// @description delete_avatar_by_name(pName)
/// @function delete_avatar_by_name
/// @param pName
var pName = argument0

for (var i=0; i<instance_number(avatar); i++)
{
    ID = instance_find(avatar,i)
    if objVarRead(ID,"pName") = pName
    {
        with ID instance_destroy()
        
        return true
    }
}

return false