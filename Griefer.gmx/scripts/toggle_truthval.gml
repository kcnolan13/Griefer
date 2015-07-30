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
else if string_upper(str) = "ALWAYS"
    return "Never"
else if string_upper(str) = "NEVER"
    return "On Action"
else if string_upper(str) = "ON ACTION"
    return "Always"
else
{
    printf("ERROR: toggle_truthval passed: "+string(str))
    return false
}