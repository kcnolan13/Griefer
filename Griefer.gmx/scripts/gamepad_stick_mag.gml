///gamepad_stick_mag(haxis_constant, vaxis_constant)
var haxis = argument0
var vaxis = argument1

var xval = 0
var yval = 0
var ret = 0

haxis = handle_swap_sticks(haxis)
vaxis = handle_swap_sticks(vaxis)

xval = real(gamepad_axis_value(global.devno, haxis))
yval = real(gamepad_axis_value(global.devno, vaxis))

ret = point_distance(0,0,xval,yval)

return ret