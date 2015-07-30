///modal_pressed(modal_id)
var m = argument0

if not instance_exists(m) return false
if not m.visible or not m.highlightable return false

var xpos = cursor.x
var ypos = cursor.y

if m.object_index = modal_meter
{
    if point_distance(m.x,m.y,xpos,ypos) < m.radius
        return true
    else return false
}
else
{
    if xpos >= m.left and ypos >= m.top and xpos <= m.left+m.width*m.scale and ypos <= m.top+m.height*m.scale
    {
        return true
    } else return false
}