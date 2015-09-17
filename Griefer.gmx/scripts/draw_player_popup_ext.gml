///draw_player_popup_ext(x, y, pName, rank, global_rank, trueskill, head_spr, hat_spr, alpha, is_bot)

var draw_x = argument0
var draw_y = argument1
var pname = string(argument2)
var rank = real(argument3)
var global_rank = real(argument4)
var trueskill = real(argument5)
var head_spr = real(argument6)
var hat_spr = real(argument7)
var alpha = argument8
var tis_bot = argument9

rank = constrict(rank, 0, getLength(global.rank_names)-1)

var rank_name = global.rank_names[rank]
var rank_color = global.rank_colors[rank]

var height = global.challenge_popup_height 
var width = global.challenge_popup_width+32
var txt_pad = 5
var icon_pad = 20

var left = 0
var top = 0
var bottom = 0
var right = 0

//INTERCEPT DAT DESCRIPTION and do things to it.. jk not in player popup
var width_less = 0
var height_less = 0

if not in_match()
{
    draw_x = cursor.x
    draw_y = cursor.y
}

alpha = alpha*0.75

if not in_match()
{
    if draw_x+net_manager.armory_sl >= room_width/2
    {
        left = draw_x - width
        right = draw_x
        top = draw_y
        bottom = draw_y+height
    }
    else
    {
        left = draw_x+net_manager.armory_ysep
        right = draw_x+width+net_manager.armory_ysep
        top = draw_y
        bottom = draw_y+height
    }
    var whiles = 0
    while (bottom > room_height) and whiles < 1000
    {
        whiles++
        bottom --
        top --
    }
}
else
{
    left = draw_x
    right = left+width
    top = draw_y
    bottom = top+height
}

//draw title rectangle

draw_set_color(rank_color)
draw_set_alpha(0.95)

draw_rectangle(left,top,right,top+height/2,false)

//draw body rectangle
draw_set_color(c_black)
draw_set_alpha(0.95)//alpha*0.8)
draw_rectangle(left,top+height/2,right,bottom,false)
draw_set_color(c_black)
//draw_set_alpha(0)
//draw_rectangle(left+icon_pad,top+icon_pad,left+(bottom-top)-icon_pad,bottom-icon_pad,false)
draw_set_alpha(alpha)

//draw the icon
//draw_bpart_icon_ext(icon, left+13, top+10, icon_scale, alpha)
varWrite("hat0",hat_spr)
varWrite("helmet0",head_spr)
draw_avatar_head(left+icon_pad+48, top+icon_pad+48, id, 0, 1, 1, FL_NOBAR)
//draw_bpart_slot_complete_ext(id, left+icon_pad, top+icon_pad, ((height-height_less)-2*icon_pad)/72, alpha)

//draw name rank
draw_set_alpha(1)
draw_set_font(fnt_hud_big)
draw_set_halign(fa_left)
draw_set_valign(fa_top)
var nr_xoff = left+net_manager.armory_ysep*3.3+net_manager.armory_sl+txt_pad+10
var nr_yoff = top+txt_pad+8
draw_namerank(capwords(pname),rank,nr_xoff,nr_yoff,1,c_white)

//draw rank name
draw_set_font(fnt_hud)
draw_set_valign(fa_top)
draw_set_color(c_white)
var sub_xoff = left+net_manager.armory_ysep*3.3+net_manager.armory_sl+txt_pad+10
var sub_yoff = top+32+txt_pad+10
draw_text_ext(sub_xoff,sub_yoff,rank_name, 24, width-145)
draw_set_color(c_white)

//draw true skill
if not tis_bot
{
    draw_set_halign(fa_right)
    draw_text_ext(left+width-txt_pad,sub_yoff,global.tskill+": "+string(trueskill),24,width*2/3)
    
    //draw global rank
    draw_set_halign(fa_left)
    var globrank = global_rank_2str(global_rank)
    var globranktxt = "Ranked "+globrank+" in the World"
    var glob_xoff = left+net_manager.armory_ysep*3.3+net_manager.armory_sl+txt_pad+10
    var glob_yoff = top+height/2+txt_pad+5
    draw_set_valign(fa_top)
    draw_text_ext(glob_xoff,glob_yoff,globranktxt, 24, width-145)
    
    if menmode() != "armory" and not net_manager.lock_armory
    {
        draw_set_alpha(0.5)
        draw_text_ext(glob_xoff,glob_yoff+28,"[Click for Stats]", 24, width-145)
    }
}
draw_set_alpha(1)
