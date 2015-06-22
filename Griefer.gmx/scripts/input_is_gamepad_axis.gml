///input_is_gamepad_axis(control_constant)
var input_const = argument0

if input_const = gp_axislh
    or input_const = gp_axislv
    or input_const = gp_axisrh
    or input_const = gp_axisrv
        return true
    
return false