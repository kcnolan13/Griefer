/// @description truthval(str)
/// @function truthval
/// @param str
var str = string(argument0)

if string_upper(str) = "ON"
    return true
else if string_upper(str) = "OFF"
    return false
else if string_upper(str) = "YES"
    return true
else if string_upper(str) = "NO"
    return false
else if string_upper(str) = "ALWAYS"
    return 1
else if string_upper(str) = "NEVER"
    return 0
else if string_upper(str) = "ON ACTION"
    return 2
else
{
    printf("ERROR: truthval passed: "+string(str))
    return false
}