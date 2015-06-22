    ///draw_player_popup(avatar_obj, x, y)
var av = argument0
var xdraw = argument1
var ydraw = argument2

if xdraw = mouse_x and ydraw = mouse_y and global.using_gamepad
{
    xdraw = cursor.x
    ydraw = cursor.y
}

if not instance_exists(av) or not av.object_index = avatar
{
    printf("ERROR: cannot draw player object. BAD AVATAR HANDLE")
    return false
}

var rank = objVarRead(av,"rank")
var global_rank = objVarRead(av,"global_rank")
var rank_name = global.rank_names[rank]
var rank_color = global.rank_colors[rank]

if xdraw < room_width/2
xdraw -= net_manager.armory_sl
draw_set_alpha(global.player_popup_alpha)

if not is_bot(av)
    var globrank = global_rank_2str(global_rank)
else
    var globrank = ""

draw_popup(xdraw, ydraw, "", rank_name, "", globrank, rank_color, 1)

//now just need to draw his player tag in the right spot
draw_namerank(objVarRead(av,"pName"),rank,left+6,top+6,1,c_white) //left and top is set in draw_popup
draw_set_alpha(1)