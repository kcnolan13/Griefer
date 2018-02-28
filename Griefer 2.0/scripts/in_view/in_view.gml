/// @description in_view(object, tolerance)
/// @function in_view
/// @param object
/// @param  tolerance
var obj = argument0
var tol = argument1

if obj.x > __view_get( e__VW.XView, 0 )-tol and obj.y > __view_get( e__VW.YView, 0 )-tol and obj.x < __view_get( e__VW.XView, 0 )+__view_get( e__VW.WView, 0 )+tol and obj.y < __view_get( e__VW.YView, 0 )+__view_get( e__VW.HView, 0 )+tol
    return true
else return false