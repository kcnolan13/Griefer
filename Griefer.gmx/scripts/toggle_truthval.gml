///toggle_truthval(str)
var str = string(argument0)

if string_upper(str) = "ON"
    return "Off"
else if string_upper(str) = "OFF"
    return "On"
else if string_upper(str) = "YES"
    return "No"
else if string_upper(str) = "NO"
    return "Yes"
else
{
    printf("ERROR: toggle_truthval passed: "+string(str))
    return false
}
