/// @description rect_highlighted(left,top,right,bottom)
/// @function rect_highlighted
/// @param left
/// @param top
/// @param right
/// @param bottom
var l = argument0
var t = argument1
var r = argument2
var b = argument3

if cursor.x >= l and cursor.y >= t and cursor.x <= r and cursor.y <= b
{
    return true
}
else return false