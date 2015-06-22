///boom_boom_pow(action_text, color)
var action_text = argument0
var col = argument1

{
    ID = instance_create(x,y,action_word)
    ID.txt = action_text
    ID.col = col
    return ID
}