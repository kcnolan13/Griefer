/// @description all dat ish
if instance_exists(bn_input) and fade_out
{
    bn_input.fade_out = true
}

event_inherited()
label = text
life++

bns[0] = bn_yes
bns[1] = bn_no
bns[2] = bn_okay
bns[3] = bn_input

if is_tips
{
    tip_counter += real_speed(1)
    if tip_counter > tip_timeout
    {
        tip_counter = 0
        tip_index++
        
        if tip_index > getLength(net_manager.pre)
            tip_index = 0
        if tip_index < 0
            tip_index = 0
            
        text = tip_text(tip_index)
    }
    /*if nth_frame(5)
    {
        printf("::: text = "+string(text)+", text_yoff = "+string(text_yoff))
    }*/
}

//allow to exit loading
if is_loading
{
    
    //loading_counter += loading_counter_inc
    //if loading_counter > loading_counter_max
    {
        loading_counter = 0
    }
    
    if load_life_max and life > load_life_max
    {
        fade_out = true    
        printf(":::WARNING: loading dialogue closed due to load_life_max")
    }

    if not fade_out and load_closable and popped_in and
                    (input_check(mapped_control(C_CROUCH)) or keyboard_check(vk_escape) 
                    or keyboard_check(vk_space) or keyboard_check(vk_enter))
    {
        fade_out = true
    }
}

if is_ui_countdown
{
    text = "Match Countdown ... "+string(ceil(objVarRead(net_manager,"lobby_wait_time")/30))
}

if is_downloading
{
    text = "Downloading Important Updates"
}

for (var i=0; i<getLength(bns); i++)
{
    var bn = bns[i]
    {
        if instance_exists(bn)
        {
            bn.width = bn.iwidth*scale
            bn.height = bn.iheight*scale
        }
    }
}

if is_loading
{
    load_rot += load_rot_inc
    if load_rot > 360
        load_rot = 0
}

/* */
/*  */
