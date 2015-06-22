///draw_avatar_head(x, y, avatar_object, score, scale, flip, flag)

var xdraw = argument0
var ydraw = argument1
var av = argument2
var av_score = argument3
var av_scale = argument4
var flip = argument5
var flag = argument6

var head_spr = objVarRead(av,"helmet0")

if is_sprite_none(head_spr)
{
    head_spr -= spr_helmet_none
}

var hat_spr = real(objVarRead(av,"hat0"))

var rot_adjust = -5*flip
var barx = 0
var bary = 0
var heady = -4
var headx = 0

var hat_xoff = 4.6
var hat_yoff = -36
var hat_rot = 12*flip*-1

if flip = 1
{
    hat_rot += 16
    hat_yoff += 2
}

var head_xoff = 6.1
var head_yoff = -22.55
var head_rot = 13*flip*-1

var head_prescaler = 2.25

var alph = 1
if object_index = action_word
    alph = alpha

//draw the head
if sprite_exists(head_spr)
    draw_sprite_ext(head_spr,-1,xdraw,ydraw+heady*head_prescaler,flip*head_prescaler*av_scale,head_prescaler*av_scale,head_rot+rot_adjust*flip,c_white,alph)
if not is_hatless(head_spr) and sprite_exists(hat_spr)
    draw_sprite_ext(hat_spr,-1,xdraw+head_prescaler*(hat_xoff-head_xoff),ydraw+head_prescaler*av_scale*(heady+hat_yoff-head_yoff),flip*head_prescaler*av_scale,head_prescaler*av_scale,hat_rot+rot_adjust*flip,c_white,alph)

//draw the black bar
if flag != FL_NOBAR
{
    draw_set_alpha(1)
    draw_set_color(c_black)
    draw_sprite(spr_fhead_bar,-1,xdraw+barx*av_scale,ydraw+bary*av_scale)
    draw_set_alpha(global.fhead_alpha)
    
    //draw the score over the black bar
    draw_set_font(global.fhead_font)
    draw_set_color(c_white)
    draw_set_halign(fa_center)
    draw_set_valign(fa_center)
    draw_set_alpha(1)
    draw_text(xdraw,ydraw,av_score)
}

draw_set_alpha(1)