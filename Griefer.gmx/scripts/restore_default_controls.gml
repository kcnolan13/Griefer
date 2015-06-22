///restore_default_controls(FL_KEYBOARD or FL_GAMEPAD)
var fl = argument0

for (var i=0; i<getLength(global.cactions); i++)
{
    ID = instance_find(bn_cedit,i)
    if instance_exists(ID)
    {
        if fl = FL_KEYBOARD
        {
            ID.text_normal = get_input_name(global.cdefaults[i])
            ID.sens_val = real(get_input_name(global.cdefaults[i]))
            global.cvals[i] = global.cdefaults[i]
        }
        else
        {
            ID.text_normal = get_input_name(global.cgpdefaults[i])
            ID.sens_val = real(get_input_name(global.cgpdefaults[i]))
            global.cvals[i] = global.cgpdefaults[i]
        }
    }
}

///send to server
transmit_control_map(fl)