///truthval(str)
var str = string(argument0)

if string_upper(str) = "ON"
    return true
else if string_upper(str) = "OFF"
    return false
else if string_upper(str) = "YES"
    return true
else if string_upper(str) = "NO"
    return false
else
{
    printf("ERROR: truthval passed: "+string(str))
    return false
}
