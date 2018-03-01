/// @description no gamepad: control with mouse
    
x = mouse_x
y = mouse_y 

var rad_target = point_rad_normal
var rot_target = rot_normal
var size_target = point_size_normal

if highlighted
{
    highlighted --//sub_real(highlighted,1)
    
    rad_target = point_rad_highlighted
    rot_target = rot_highlighted
    size_target = point_size_highlighted
}

point_rad = lerp(point_rad,rad_target,point_rad_lerp)
rot = lerp(rot,rot_target,rot_lerp)
point_size = lerp(point_size,size_target,point_size_lerp)

