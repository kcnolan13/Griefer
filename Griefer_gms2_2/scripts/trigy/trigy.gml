/// @description trigy(mag, angle)
/// @function trigy
/// @param mag
/// @param  angle
mag = real(argument0)
angle = real(argument1)

return -1*mag*(sin(degtorad(angle mod 360)))