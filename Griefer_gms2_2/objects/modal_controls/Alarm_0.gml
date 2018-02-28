/// @description create all the control edit fields and labels

if halign = fa_center
    x -= width/2
if valign = fa_center
    y -= height/2

y_adder -= height/2
x_adder -= width/2

//create the big tabs
var bdelay = 1
var binc = 2

w = 72*4
hspacer = w+36
xoff = -150

h = 72
yoff = top-(h+12)+72

someval = 12
colval = 0

//POSSIBLY GEN SETTINGS IN MIDDLE
if behave_match
{
    //MATCH SETTINGS
    blah = instance_create(left+width*4/5-hspacer+xoff,yoff,bn_match_settings)
    blah.width = w
    blah.height = h
    blah.depth = depth-1
    blah.birth_delay = bdelay
    blah.hue = 20
    blah.sat = 0
    blah.val = colval
    blah.color = web_hsv(chue,csat,colval)
    blah.active_color = web_hsv(chue*chue_mult,csat*csat_mult,someval*cval_mult)
    blah.text_halign = fa_left
    blah.text_xoff = 72+5
    blah.text_color = text_color
    blah.image = icon_settings
    with blah
    {
        modal_aligns()
        modal_recalculate_snap()
    }
    bdelay += binc
    
    //GEN SETTINGS
    blah = instance_create(left+width*4/5+xoff,yoff,bn_gen_settings)
    blah.width = w
    blah.height = h
    blah.depth = depth-1
    blah.birth_delay = bdelay
    blah.hue = 20
    blah.sat = 0
    blah.val = colval
    blah.color = web_hsv(chue,csat,colval)
    blah.active_color = web_hsv(chue*chue_mult,csat*csat_mult,someval*cval_mult)
    blah.text_halign = fa_left
    blah.text_xoff = 72+5
    blah.text_color = text_color
    blah.image = icon_settings
    with blah
    {
        modal_aligns()
        modal_recalculate_snap()
    }
    bdelay += binc
    
    //CONTROL SETTINGS
    blah = instance_create(left+width*4/5+hspacer+xoff,yoff,bn_control_settings)
    blah.width = w
    blah.height = h
    blah.depth = depth-1
    blah.birth_delay = bdelay
    blah.hue = 20
    blah.sat = 0
    blah.val = colval
    blah.color = web_hsv(chue,csat,colval)
    blah.active_color = web_hsv(chue*chue_mult,csat*csat_mult,someval*cval_mult)
    blah.text_halign = fa_left
    blah.text_xoff = 72+5
    blah.text_color = text_color
    blah.image = icon_settings
    with blah
    {
        modal_aligns()
        modal_recalculate_snap()
    }
    bdelay += binc
}
else
{
    //GEN SETTINGS
    blah = instance_create(left+width*4/5-hspacer+xoff,yoff,bn_gen_settings)
    blah.width = w
    blah.height = h
    blah.depth = depth-1
    blah.birth_delay = bdelay
    blah.hue = 20
    blah.sat = 0
    blah.val = colval
    blah.color = web_hsv(chue,csat,colval)
    blah.active_color = web_hsv(chue*chue_mult,csat*csat_mult,someval*cval_mult)
    blah.text_halign = fa_left
    blah.text_xoff = 72+5
    blah.text_color = text_color
    blah.image = icon_settings
    with blah
    {
        modal_aligns()
        modal_recalculate_snap()
    }
    bdelay += binc

    //CONTROL SETTINGS
    blah = instance_create(left+width*4/5+xoff,yoff,bn_control_settings)
    blah.width = w
    blah.height = h
    blah.depth = depth-1
    blah.birth_delay = bdelay
    blah.hue = 20
    blah.sat = 0
    blah.val = colval
    blah.color = web_hsv(chue,csat,colval)
    blah.active_color = web_hsv(chue*chue_mult,csat*csat_mult,someval*cval_mult)
    blah.text_halign = fa_left
    blah.text_xoff = 72+5
    blah.text_color = text_color
    blah.image = icon_settings
    with blah
    {
        modal_aligns()
        modal_recalculate_snap()
    }
    bdelay += binc
    
    //LOG OUT
    blah = instance_create(left+width*4/5+hspacer+xoff,yoff,bn_logout_settings)
    blah.width = w
    blah.height = h
    blah.depth = depth-1
    blah.birth_delay = bdelay
    blah.hue = 20
    blah.sat = 0
    blah.val = colval
    blah.color = web_hsv(chue,csat,colval)
    blah.active_color = web_hsv(chue*chue_mult,csat*csat_mult,someval*cval_mult)
    blah.text_halign = fa_left
    blah.text_xoff = 72+5
    blah.text_color = text_color
    blah.image = icon_quit
    with blah
    {
        modal_aligns()
        modal_recalculate_snap()
    }
    bdelay += binc
}




