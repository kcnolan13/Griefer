///transmit_control_map(FL_KEYBOARD or FL_GAMEPAD)
var fl = argument0

var using_gamepad = false
if fl = FL_GAMEPAD
    using_gamepad = true
    
for (var i=0; i< getLength(global.cvals); i++)
{
    sendBigMessageReal("control_map",i,real(global.cvals[i]),real(using_gamepad))
}