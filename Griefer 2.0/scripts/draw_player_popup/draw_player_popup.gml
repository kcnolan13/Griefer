    ///draw_player_popup(avatar_obj, x, y)
var av = argument0
var xdraw = argument1
var ydraw = argument2

if xdraw = mouse_x and ydraw = mouse_y and global.using_gamepad
{
    xdraw = cursor.x
    ydraw = cursor.y
}

if not instance_exists(av) or av.object_index != avatar
{
    printf("ERROR: cannot draw player object. BAD AVATAR HANDLE")
    return false
}

var rank = objVarRead(av,"rank")
var global_rank = objVarRead(av,"global_rank")
var tskill = objVarRead(av,"true_skill")
var rank_name = global.rank_names[rank]
var rank_color = global.rank_colors[rank]

if global_rank < 0 or tskill < 0
{
    printf("ERROR: cannot draw player popup -- global_rank="+string(global_rank)+", tskill="+string(tskill))
    return false
}

if xdraw < room_width/2
xdraw -= net_manager.armory_sl
draw_set_alpha(global.player_popup_alpha)

if not is_bot(av)
    var globrank = global_rank_2str(global_rank)
else
    var globrank = ""

var body_text_override = ""

if not is_bot(av)
    body_text_override = global.tskill+" "+string(tskill)+"#####Ranked  "+string(globrank)+"  In The World#####"

body_text_override += "Click for Stats!"

draw_popup(xdraw, ydraw, "", rank_name, "", body_text_override, rank_color, 1)

//now just need to draw his player tag in the right spot
draw_namerank(capwords(objVarRead(av,"pName")),rank,pleft+6,ptop+6,1,c_white) //left and top is set in draw_popup
draw_set_alpha(1)
