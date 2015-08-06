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
var nu_width = nr_width-20*scale
var nu_height = nr_height
var xsep = 10*scale
var rank_sep = 2*scale-8

nr_width = nr_width+20*scale

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
draw_rectangle(left,top-5,left+nr_width,top+nr_height,false)
draw_rectangle(left+nr_width+xsep,top-5,right,top+nu_height,false)
draw_set_alpha(1*alpha)
draw_set_color(c_white)

rank += 1
var rank_name = get_rank_name(rank)
var rank_xp = get_rank_xp(rank)
var xp_needed = rank_xp-xp

if rank<0 rank = 0

// DRAW_NAMERANK
var name = capwords(rank_name)
var draw_x = left+rank_sep+10*scale
var draw_y = top+rank_sep+8*scale
var scale = 1*scale
color = c_white
draw_player_rank(rank, draw_x, draw_y, scale)
draw_set_color(color)
draw_set_font(fnt_hud)
draw_set_halign(fa_left)
draw_set_valign(fa_middle)
draw_flash_compensate()
draw_text_ext_transformed(draw_x+5*scale+global.rank_radius*scale*2,draw_y+5,name,0,600,scale,scale,0)
//END

draw_set_color(text_color)
draw_set_alpha(0.9*alpha) draw_set_halign(fa_center) draw_set_valign(fa_top)
draw_set_font(fnt_hud_big)
if xp_needed > 0
{
    draw_text(left+nr_width/2,top+nr_height*1/3,string(floor(xp_needed)))
    draw_text(left+nr_width/2,top+nr_height*1/3+20*scale,"XP Remaining")
}
draw_set_font(fnt_hud)

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
    draw_text_ext(nu_left+nu_width/2,top+rank_sep,"Next Armor Set:#"+bpart_lookup(get_rank_unlock_sprite(rnum),global.BPART_NAME),18,500)
    
    var slot_width = 72
    var slot_scale = slot_width/72
    
    draw_bpart_slot_complete_ext(id,nu_left+nu_width/2-slot_width/2,top+nu_height*1/3,slot_scale,1*alpha)
    
    //lock icon
    draw_set_alpha(0.75*alpha)
    draw_set_color(c_white)
    draw_sprite(icon_lock,-1,nu_left+8,top+45)
    
    draw_set_alpha(0.4*alpha)
    //draw_player_rank(rnum,nu_left+11,top+nu_height*1/2,scale)
    draw_set_alpha(1)
}

return true
