///boom_boom_pow(action_text, color)
var action_text = argument0
var col = argument1

{
    ID = instance_create(x-view_xview,y-view_yview,action_word)
    ID.txt = action_text
    ID.col = col
    ID.scale = 1.5
    return ID
}