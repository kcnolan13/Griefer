/// @description boom_boom_pow(action_text, color)
/// @function boom_boom_pow
/// @param action_text
/// @param  color
var action_text = argument0
var col = argument1

{
    ID = instance_create(x-__view_get( e__VW.XView, 0 ),y-__view_get( e__VW.YView, 0 ),action_word)
    ID.txt = action_text
    ID.col = col
    ID.scale = 1.5
    return ID
}