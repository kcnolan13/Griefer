///in_view(object, tolerance)
var obj = argument0
var tol = argument1

if obj.x > view_xview-tol and obj.y > view_yview-tol and obj.x < view_xview+view_wview+tol and obj.y < view_yview+view_hview+tol
    return true
else return false