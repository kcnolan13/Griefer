/// @description adjust for aligns and create buttons

if birth_delay
{
    alarm[0] = 1
    exit
}

modal_aligns()

if not is_loading
    header_height = height/4
    
bdelay = 10
binc = 5
text_pad = width/12

if is_tutorial
{
    header_color = web_hsv(228,58,80)
    alpha_max = 1
    draw_fade = true
    draw_gradient = true
    font = fnt_hud
    text_yoff = 84
}

if critical
{
    header_color = c_red
    font = fnt_hud_small
}
    
if is_yesno
{
    bn_yes = instance_create(x-width/4,y+height/2*3/4,bn_dialogue)
    bn_yes.text = text_yes
    bn_yes.script = scr_yes
    bn_yes.depth = depth -10
    bn_yes.parent_dialogue = id
    bn_yes.scale_lerp_real = scale_lerp_real
    bn_yes.birth_delay = bdelay
    bdelay += binc

    bn_no = instance_create(x+width/4,y+height/2*3/4,bn_dialogue)
    bn_no.text = text_no
    bn_no.script = scr_no
    bn_no.depth = depth -10
    bn_no.parent_dialogue = id
    bn_no.scale_lerp_real = scale_lerp_real
    bn_no.birth_delay = bdelay
    bdelay += binc
}
else if not is_alert and not is_loading and not is_input_field and not is_tips
{
    bn_okay = instance_create(x,y+height/2*3/4,bn_dialogue)
    bn_okay.text = text_okay
    bn_okay.script = scr_okay
    bn_okay.depth = depth -10
    bn_okay.parent_dialogue = id
    bn_okay.scale_lerp_real = scale_lerp_real
    bn_okay.birth_delay = bdelay
    bdelay += binc
}
else if is_tips
{
    var w = 64
    {
        bn_okay = noone
        /*
        bn_okay = instance_create(x+width/2+w/2+10,y,bn_dialogue)
        bn_okay.text = text_okay
        bn_okay.script = scr_okay
        bn_okay.depth = depth -10
        bn_okay.parent_dialogue = id
        bn_okay.scale_lerp_real = scale_lerp_real
        bn_okay.birth_delay = bdelay
        bn_okay.is_gui = true
        bn_okay.height = height/2
        bn_okay.width = w
        bn_okay.y = y+(height/4)
        bn_okay.alpha_max = alpha_max
        bn_okay.header_height = 0
        bdelay += binc
        */
    }
}
else if is_alert
{
    text_valign = fa_center
    text_yoff = 0
}
else if is_input_field
{
    bn_input = instance_create(x,y,bn_input_field)
    bn_input.width = WVIEW/5*4/5
    bn_input.height = 64*0.8
    bn_input.iwidth = bn_input.width
    bn_input.iheight = bn_input.height
    bn_input.birth_delay = bdelay
    bdelay += binc
    bn_input.depth = depth-10
    bn_input.auto_start = true
    bn_input.sequence = 1
    bn_input.text_color_input = c_black
    bn_input.text_color_default = c_white
    bn_input.color = web_hsv(220,0,55)
    bn_input.active_color = web_hsv(235,0,85)
    bn_input.is_gui = true
    
    if is_password
    {
        bn_input.max_length = 20
        bn_input.is_password = true
        bn_input.text_default = "Password"
        bn_input.text = bn_input.text_default
        bn_input.min_length = 6
    }
    
    bn_yes = instance_create(x-width/4,y+height/2*3/4,bn_dialogue)
    bn_yes.text = text_okay
    bn_yes.script = scr_okay
    bn_yes.depth = depth -10
    bn_yes.parent_dialogue = id
    bn_yes.scale_lerp_real = scale_lerp_real
    bn_yes.birth_delay = bdelay
    bdelay += binc

    bn_no = instance_create(x+width/4,y+height/2*3/4,bn_dialogue)
    bn_no.text = "Cancel"
    bn_no.script = scr_cancel_input
    bn_no.depth = depth -10
    bn_no.parent_dialogue = id
    bn_no.scale_lerp_real = scale_lerp_real
    bn_no.birth_delay = bdelay
    bdelay += binc
}

/* */
/*  */
