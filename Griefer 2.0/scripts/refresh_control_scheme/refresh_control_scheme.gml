/// @description refresh_control_scheme(FL_KEYBOARD or FL_GAMEPAD)
/// @function refresh_control_scheme
/// @param FL_KEYBOARD or FL_GAMEPAD
var fl = argument0

printf("::: REFRESHING CONTROL SCHEME")

if fl = FL_KEYBOARD
{
    global.using_gamepad = false
}
else
{
    global.using_gamepad = true
}

for (var i=0; i<getLength(global.cactions); i++)
{
    ID = instance_find(bn_cedit,i)
    
    if fl = FL_KEYBOARD
    {
        global.cvals[i] = global.mydefaults[i]
    }
    else
    {
        global.cvals[i] = global.mygpdefaults[i]
    }
    
    if instance_exists(ID)
    {
        if fl = FL_KEYBOARD
        {
            global.cvals[i] = global.mydefaults[i]
            ID.text_normal = get_input_name(global.mydefaults[i])
            ID.text = ID.text_normal
            ID.label = ID.text
            ID.label_name = global.cactions[i]
            ID.sens_val = real(global.mydefaults[i])
            ID.recompute_sens_percent = true
        }
        else
        {
            global.cvals[i] = global.mygpdefaults[i]
            ID.text_normal = get_input_name(global.mygpdefaults[i])
            ID.text = ID.text_normal
            ID.label = ID.text
            ID.label_name = global.cactions[i]
            ID.sens_val = real(global.mygpdefaults[i])
            ID.recompute_sens_percent = true
        }
    }
}

with bn_cedit
{
    scale = 0
    alpha = 0
}

with bn_clabel
{
    scale = 0
    alpha = 0
}