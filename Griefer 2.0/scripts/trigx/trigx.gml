/// @description trigx(mag, angle)
/// @function trigx
/// @param mag
/// @param  angle
mag = real(argument0)
angle = real(argument1)

return mag*(cos(degtorad(angle mod 360)))