///find_obj_with_id(obj_index,unique_id)
obj_index = argument0
unique_id = argument1

var i=0
printf("finding obj with id")
for (i=0; i<instance_number(obj_index); i++)
{
    var handle = instance_find(obj_index,i)
    if (real(objVarRead(handle,"uniqueId")) = real(unique_id)) or (hash_string(string(objVarRead(handle,"pName"))) = real(unique_id))
    {
        if hash_string(string(objVarRead(handle,"pName"))) = real(unique_id)
            printf("found obj with ID by using hash_string on pName")
        else
            printf("found obj with ID normally")
        return handle
    }
}

//couldn't find an object that matches
if DEBUG
    printf("couldn't find an (object "+obj_index+") with uniqueId "+unique_id+"... analyzed "+instance_number(obj_index)+" instances")

//failure
printf("found obj with id failed")
return NO_HANDLE