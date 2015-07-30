///web_hsv(hue,sat,val)

var h = real(argument0)
var s = real(argument1)
var v = real(argument2)

return make_colour_hsv(h*255/360,s*255/100,v*255/100)