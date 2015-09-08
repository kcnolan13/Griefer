///regen_cedits(FL_CEDITS or FL_NORMAL)
var fl = argument0

printf("::: REGENERATING CEDITS")

if instance_exists(modal_controls) and object_index != modal_controls
{
    with modal_controls
        regen_cedits(fl)
}
else
{
    //clear arrays
    labels = 0
    cnames = 0
    is_senses = 0
    
    labels[0] = "blah"
    cnames[0] = "blah"
    is_senses[0] = false
    
    var bdelay = 1
    var binc = 2
    
    w = 72*4
    h = 55
    hspacer = w+36
    yoff = top+62
    xoff = 40+x_adder
    
    //make local copy of global control names (for no reason)
    if fl = FL_GEN_SETTINGS
    {
        //create general settings
        for (var i=0; i<array_height_2d(global.gc); i++)
        {
            labels[i] = global.gc[i,0]
            cnames[i] = global.gc[i,1]
            is_senses[i] = global.gc[i,2]
        }   
    }
    else if fl = FL_MATCH_SETTINGS
    {
        hspacer = w*2
        //create dat one button and trigger draw scores + table and whatnot
        blah = instance_create(left+width*4/5+296+xoff,yoff,bn_match_quit)
        blah.width = w-32
        blah.height = h
        blah.depth = depth-1
        blah.birth_delay = 1
        blah.hue = 218
        blah.sat = 100
        blah.val = 100
        blah.color = web_hsv(chue,csat,cval)
        blah.active_color = web_hsv(chue*chue_mult,csat*csat_mult,cval*cval_mult)
        blah.text_halign = fa_left
        blah.text_xoff = 72+5
        blah.text_color = text_color
        blah.image = icon_settings
        return true
    }
    else
    {
        for (var i=0; i<getLength(global.cactions); i++)
        {
            labels[i] = get_caction_name(i)
            cnames[i] = get_input_name(global.cvals[i])
            is_senses[i] = false
        }
    }
    
    //THE RESTORE DEFAULTS BUTTON
    if fl = FL_NORMAL
    {
        some_extra = 64*1.5
        
        blah = instance_create(left+width*4/5+hspacer+xoff+some_extra,yoff,bn_restore_defaults)
        blah.width = w
        blah.height = h
        blah.depth = depth-1
        blah.birth_delay = bdelay
        blah.hue = 20
        blah.sat = 0
        blah.val = 30
        blah.color = web_hsv(chue,csat,cval)
        blah.active_color = web_hsv(chue*chue_mult,csat*csat_mult,cval*cval_mult)
        blah.text_halign = fa_left
        blah.text_xoff = 72+5
        blah.text_color = text_color
        blah.image = icon_settings
        bdelay += binc
        
        //USE KEYBOARD BUTTON
        blah = instance_create(left+width*4/5-hspacer+xoff+some_extra,yoff,bn_use_keyboard)
        blah.width = w
        blah.height = h
        blah.depth = depth-1
        blah.birth_delay = bdelay
        blah.hue = 20
        blah.sat = 0
        blah.val = 30
        blah.color = web_hsv(chue,csat,cval)
        blah.active_color = web_hsv(chue*chue_mult,csat*csat_mult,cval*cval_mult)
        blah.text_halign = fa_left
        blah.text_xoff = 72+5
        blah.text_color = text_color
        blah.image = icon_settings
        bdelay += binc
        
        //USE GAMEPAD BUTTON
        blah = instance_create(left+width*4/5+xoff+some_extra,yoff,bn_use_gamepad)
        blah.width = w
        blah.height = h
        blah.depth = depth-1
        blah.birth_delay = bdelay
        blah.hue = 20
        blah.sat = 0
        blah.val = 30
        blah.color = web_hsv(chue,csat,cval)
        blah.active_color = web_hsv(chue*chue_mult,csat*csat_mult,cval*cval_mult)
        blah.text_halign = fa_left
        blah.text_xoff = 72+5
        blah.text_color = text_color
        blah.image = icon_settings
        
        bdelay += binc
    }    
    
    var lwidth = 64*3.5
    var lheight = 64*0.5
    var ewidth = lwidth*0.65
    var eheight = lheight
    
    var xst = left+width/4+lwidth+x_adder+64*1.5
        
    var yst_original = top+header_height+64*3+lheight+y_adder
    var yst = yst_original
    var hspacer = 64
    var vspacer = 16
    var len = getLength(labels)
    
    for (var i=0; i<len; i++)
    {
        //don't show swap sticks unless gamepad is plugged in
        if not global.using_gamepad and i=len-1 and fl != FL_GEN_SETTINGS and fl != FL_MATCH_SETTINGS
            break
            
        bdelay += binc
    
        //create the label
        ID = instance_create(xst,yst-6,bn_clabel)
        printf("::: creating control label: "+string(labels[i]))
        ID.width = lwidth
        ID.height = lheight
        ID.text = labels[i]
        ID.birth_delay = bdelay
        ID.depth = depth-1
        ID.text_halign = fa_right
        ID.text_valign = fa_center
        ID.text_color = text_color
        
        //create the edit field
        ID2 = instance_create(xst+lwidth/2+hspacer,yst,bn_cedit)
        ID2.width = ewidth
        ID2.height = eheight
        ID2.text = cnames[i]
        if string_upper(ID2.text) = "ON" or string_upper(ID2.text) = "OFF" or string_upper(ID2.text) = "ON ACTION" 
        or string_upper(ID2.text) = "ALWAYS" or string_upper(ID2.text) = "NEVER" or string_upper(ID2.text) = string_upper(global.optimize_graphics) 
        or string_upper(ID2.text) = string_upper(global.optimize_fps) or string_upper(ID2.text) = string_upper(global.txt_restore)
            ID2.is_onoff = true
        else if string_upper(ID2.text) = "YES" or string_upper(ID2.text) = "NO" 
            ID2.is_yesno = true
        ID2.birth_delay = bdelay
        ID2.depth = depth-1
        ID2.label_name = labels[i]
        ID2.using_gamepad = global.using_gamepad
        ID2.myLabel = ID
        ID.myCedit = ID2
        ID2.color = web_hsv(chue,csat,cval)
        ID2.text_color = text_color
        
        if is_senses[i] = true
        {
            ID2.is_sens = true
            ID2.sens_val = global.gc[i,1]
            ID2.exclude_zero = false
            ID2.sens_low = 0
            ID2.sens_high = 1
        }
        
        if fl != FL_GEN_SETTINGS and fl != FL_MATCH_SETTINGS
        {
            if i = C_LOOK_SENS
            {
                ID2.is_sens = true
                ID2.sens_val = global.cvals[C_LOOK_SENS]
                ID2.sens_low = global.match_cursor_speed_low
                ID2.sens_high = global.match_cursor_speed_high
            } else if i = C_MOUSE_SENS
            {
                ID2.is_sens = true
                ID2.sens_val = global.cvals[C_MOUSE_SENS]
                ID2.sens_low = global.cursor_speed_low
                ID2.sens_high = global.cursor_speed_high
            }
        }
        
        yst += (lheight+vspacer)
        
        if i = floor((len-1)/2)
        {
            xst += width/2-64
            yst = yst_original
        }
    }
}
