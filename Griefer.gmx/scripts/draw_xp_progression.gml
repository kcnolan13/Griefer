///draw_xp_progression(x,y,scale,halign,valign,text_color,alpha,rank,xp)

var dx = argument0
var dy = argument1
var scale = argument2
var halign = argument3
var valign = argument4
var text_color = argument5
var alpha = argument6
var rank = argument7
var xp = floor(argument8)

var nr_width = 64*3*scale
var nr_height = 64*1.75*scale
var nu_width = nr_width
var nu_height = nr_height
var xsep = 10*scale
var rank_sep = 2*scale

var total_width = (nr_width+nu_width+xsep)
var total_height = (max(nu_height,nr_height))

var top = dy
var left = dx

if halign = fa_center
    left -= total_width/2

if halign = fa_right
    left -= total_width
    
if valign = fa_center
    top -= total_height/2
    
if valign = fa_bottom
    top -= total_height
    
var right = left+total_width
var bottom = top+total_height

var nu_left = left+nr_width+xsep

//draw backings
//printf("ERROR: top = "+string(top)+", left = "+string(left)+", alpha = "+string(alpha))

draw_set_alpha(0.5*alpha)
draw_set_color(c_black)
draw_rectangle(left,top,left+nr_width,top+nr_height,false)
draw_rectangle(left+nr_width+xsep,top,right,top+nu_height,false)
draw_set_alpha(1*alpha)
draw_set_color(c_white)

rank += 1
var rank_name = get_rank_name(rank)
var rank_xp = get_rank_xp(rank)
var xp_needed = rank_xp-xp

if rank<0 rank = 0
draw_namerank(rank_name,rank,left+rank_sep+10*scale,top+rank_sep+8*scale,1*scale,c_white)
draw_set_color(text_color)
draw_set_alpha(0.9*alpha) draw_set_halign(fa_center) draw_set_valign(fa_top)
draw_set_font(fnt_hud)
if xp_needed > 0
{
    draw_text(left+nr_width/2,top+nr_height*1/2,string(floor(xp_needed)))
    draw_text(left+nr_width/2,top+nr_height*1/2+24*scale,"XP Remaining")
}

//lock icon
draw_set_alpha(0.75*alpha)
draw_set_color(c_white)
draw_sprite(icon_lock,-1,nu_left+4,top+4)

//rank was next rank
rank--

icon = next_unlock_spr(rank)//get_rank_unlock_sprite(rank)
rnum = next_unlock_rank(rank)

disabled = false
color = get_bpart_color(icon)

if icon != spr_none
{
    //next unlock text
    draw_set_alpha(alpha)
    draw_set_halign(fa_center) draw_set_valign(fa_top)
    draw_text(nu_left+nu_width/2,top+rank_sep,"Next Unlock:")
    
    var slot_width = 72
    var slot_scale = slot_width/72
    
    draw_bpart_slot_complete_ext(id,nu_left+nu_width/2-slot_width/2,top+nu_height*1/3,slot_scale,1*alpha)
    draw_player_rank(rnum,nu_left+11,top+nu_height*1/2,scale)
}

return true