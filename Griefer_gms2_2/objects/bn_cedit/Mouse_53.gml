/// @description all dat ish
if not modal_highlighted(id)
{
    exit_child = true
    exit
}

if clicked exit
    clicked = 2

printf("clicked: "+label)
audio(snd_click,1)

if not is_onoff and not is_yesno and text != "Go"
{
    if instance_exists(myLabel) and myLabel.text != global.cactions[C_SWAP_STICKS]
    {
        text = "Capturing ..."
        capturing = true
    }
    else
    {
        global.cvals[C_SWAP_STICKS] ^= 1
        
        if global.using_gamepad
            transmit_control_map(FL_GAMEPAD)
        else
            transmit_control_map(FL_KEYBOARD)
    }
}
else
{
    var ind = gc_ind(myLabel.text)
    
    if ind != GC_DEFAULTS and ind != GC_PASSWORD
        text = toggle_truthval(text)

    //ADJUST THE REAL SETTING VARIABLES BASED ON MYLABEL TEXT
    if ind > -1
    {
        if ind != GC_DEFAULTS and ind != GC_PASSWORD
        {
            global.gc[ind,1] = toggle_truthval(global.gc[ind,1])
            //send to server
            save_setting(ind)
        }
        
        if ind = GC_VSYNC
        {
            var aa = display_aa
            if aa < 2       aa = 0
            else if aa < 4  aa = 2
            else if aa < 8  aa = 4
            else            aa = 8
                global.vsync = truthval(global.gc[GC_VSYNC,1])
                if not truthval(global.gc[GC_VSYNC,1])
                    display_reset(0,false)
                else
                    display_reset(aa,true)
        }
        
        if ind = GC_CONTROL_HINTS
        {
            var val = truthval(global.gc[GC_CONTROL_HINTS,1])
            if val 
                create_control_tips()
            else
                hide_control_tips()
        }
        
        //perform actions as needed
        if ind = GC_FPS
        {  
            var aa = display_aa
            if aa < 2       aa = 0
            else if aa < 4  aa = 2
            else if aa < 8  aa = 4
            else            aa = 8

            if global.gc[GC_FPS,1] = global.optimize_graphics
            {
                //optimize graphics
                global.gc[GC_AA_LEVEL,1] = 1
                save_setting(GC_AA_LEVEL)
                draw_set_swf_aa_level(global.gc[GC_AA_LEVEL,1])
                
                global.gc[GC_VSYNC,1] = "On"
                save_setting(GC_VSYNC)
                display_reset(aa,true)
                global.vsync = true
                
                global.gc[GC_PARTICLES,1] = "On"
                save_setting(GC_PARTICLES)
                
                global.gc[GC_RAGDOLLS,1] = "On"
                save_setting(GC_RAGDOLLS)
                
                global.gc[GC_SURFACES,1] = "On"
                save_setting(GC_PARTICLES)
                
                regen_control_ui()
            }
            else if global.gc[GC_FPS,1] = global.optimize_fps
            {
                //optimize fps
                global.gc[GC_AA_LEVEL,1] = 0
                save_setting(GC_AA_LEVEL)
                draw_set_swf_aa_level(global.gc[GC_AA_LEVEL,1])
                
                global.gc[GC_PARTICLES,1] = "Off"
                save_setting(GC_PARTICLES)
                
                global.gc[GC_VSYNC,1] = "Off"
                save_setting(GC_VSYNC)
                display_reset(0,false)
                global.vsync = false
                
                global.gc[GC_RAGDOLLS,1] = "Off"
                save_setting(GC_RAGDOLLS)
                
                global.gc[GC_SURFACES,1] = "Off"
                save_setting(GC_SURFACES)
                
                regen_control_ui()
            }
        }
        else if ind = GC_DEFAULTS
        {
            for (var i=0; i<array_height_2d(global.gc); i++)
            {
                for (var j=0; j<3; j++)
                {
                    global.gc[i,j] = global.gc_defaults[i,j]
                    printf("::: setting gc["+string(i)+","+string(j)+"] = "+string(global.gc_defaults[i,j]))
                }
                save_setting(i)
            }
            draw_set_swf_aa_level(global.gc[GC_AA_LEVEL,1])
            regen_control_ui()
        }
        else if ind = GC_PASSWORD
        {
            ID = popup_input(WVIEW/2,HVIEW/2,true,"Change Password",scr_change_password)
        }
    }
    else
    {
        printf("ERROR: could not toggle bn_cedit due to bad gc_ind")
    }
}

