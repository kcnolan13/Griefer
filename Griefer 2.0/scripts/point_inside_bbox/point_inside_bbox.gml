/// @description point_inside_bbox(x,y)
/// @function point_inside_bbox
/// @param x
/// @param y
var xcheck = x
var ycheck = y

if xcheck >= bbox_left and xcheck <= bbox_right and ycheck >= bbox_top and ycheck <= bbox_bottom
    return true
else
    return false