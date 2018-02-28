/// @description extract_uid(oid_string)
/// @function extract_uid
/// @param oid_string
var oid_str = argument0
var pos = string_pos(":",oid_str)

if pos < 1
{
    printf("ERROR: bad oid string")
    return -52
}

var res = 0

return string(string_copy(oid_str,pos+1,string_length(oid_str)-pos))
