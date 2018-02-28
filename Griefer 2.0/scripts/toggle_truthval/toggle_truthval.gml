/// @description toggle_truthval(str)
/// @function toggle_truthval
/// @param str
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
else if string_upper(str) = string_upper(global.optimize_graphics)
    return global.optimize_fps
else if string_upper(str) = string_upper(global.optimize_fps)
    return global.optimize_graphics
else
{
    printf(":::WARNING unknown toggle_truthval passed: "+string(str))
    return str
}
