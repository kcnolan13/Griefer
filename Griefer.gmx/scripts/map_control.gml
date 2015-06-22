///map_control(description,input_code)
var name = argument0
var code = argument1

//done capturing
with bn_cedit capturing = false

//set the control and save immediately to server
var ind = get_caction_index(name)
global.cvals[ind] = code

if global.using_gamepad
{
    global.mygpdefaults[ind] = code
    transmit_control_map(FL_GAMEPAD)
}
else
{
    global.mydefaults[ind] = code
    transmit_control_map(FL_KEYBOARD)
}

if object_index != bn_cedit
    text_normal = get_input_name(global.cvals[ind])
else if not is_sens
    text_normal = get_input_name(global.cvals[ind])