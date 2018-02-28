/// @description find_obj_with_id(obj_index,unique_id)
/// @function find_obj_with_id
/// @param obj_index
/// @param unique_id
obj_index = argument0
unique_id = argument1

var i=0
//printf("finding obj with id")
for (i=0; i<instance_number(obj_index); i++)
{
    var handle = instance_find(obj_index,i)
    if (string(objVarRead(handle,"uniqueId")) = string(unique_id)) or (string(objVarRead(handle,"pName")) = string(unique_id))
    {
        if (string(objVarRead(handle,"pName")) = string(unique_id))
            printf("found obj with ID by using hash_string on pName")
        else
            printf("found obj with ID normally")
        return handle
    }
}

//couldn't find an object that matches
//if DEBUG
  //  printf("couldn't find an (object "+obj_index+") with uniqueId "+unique_id+"... analyzed "+instance_number(obj_index)+" instances")

//failure
//printf("found obj with id failed")
return NO_HANDLE
