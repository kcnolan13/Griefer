///extract_object_index(oid_string)
var oid_str = argument0
var pos = string_pos(":",oid_str)

if pos < 1
{
    printf("ERROR: bad oid string")
    return -52
}


return real(string_copy(oid_str,1,pos))