/// @description inside_room(object)
/// @function inside_room
/// @param object
obj = argument0

if obj.x >= 0 and obj.y >= 0 and obj.x <= room_width and obj.y <= room_height
    return true
else return false