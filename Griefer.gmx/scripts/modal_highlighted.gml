///modal_pressed(modal_id)
var m = argument0
if not instance_exists(m) return false

alerts_exist = false

with modal_dialogue
{
    if is_alert
        other.alerts_exist = true
}   

if alerts_exist or m.blocked
    return false

if not force_click and instance_exists(modal_dialogue) and m.object_index != modal_dialogue and m.object_index != bn_dialogue
{
    if not (m.object_index = bn_input_field and modal_dialogue.is_input_field)
        return false
}

if not m.visible or (not m.highlightable and not force_click) return false

var xpos = cursor.x
var ypos = cursor.y

if m.is_gui
{
    xpos = (cursor.x-view_xview)/view_wview*WVIEW
    ypos = (cursor.y - view_yview)/view_hview*HVIEW
}

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
