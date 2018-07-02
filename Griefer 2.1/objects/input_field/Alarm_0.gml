/// @description cursor blink
if not keyboard_check(vk_backspace)
    blink ^= 1
else
    blink = true
    
if blink and input_active
    str_cursor = "|"
else
    str_cursor = ""
    
alarm[0] = 30/3

