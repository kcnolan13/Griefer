if not varRead("controllable") or varRead("speed_multiplier") < 0.2 or in_snare(id) return false

var speed_vwall_inc = 4

if not jumping and (collision_rectangle(bbox_left,bbox_top,bbox_right,bbox_bottom+32,block,true,true) or collision_rectangle(bbox_left,bbox_top,bbox_right,bbox_bottom+32,block2_top,true,true) or standing_2way = true)
{
    update_physics = true
    if net_manager.local_player = id
    audio(snd_jump,1)

    if crawling = 0 and rolling = 0
    {
        vsp = -speed_jump/mass*varRead("speed_multiplier")
        //audio_play_sound_at(snd_jump,0,0,0,300,800,1,false,4)
        jumping = true
        exit
    }
    else
    if !collision_rectangle(bbox_left+10,bbox_top-64,bbox_right-10,bbox_bottom-10,block,true,true)
    {
        crawling = 0
        rolling = 0
        varSub("myY",41)
        vsp = -speed_jump/mass*varRead("speed_multiplier")
        //audio_play_sound_at(snd_jump,0,0,0,300,800,1,false,4)
        jumping = true
    }
}

if slide_right = 1
{
    update_physics = true
    
    if not is_bot(id)
        audio(snd_jump,1)
        
    var vinc = 0
    var hinc = 0
    var ang = 0
    
    var datspd = speed_jump
    
    if input_check(mapped_control(C_MOVE_LEFT))
    {
        ang = ang_vwall
        datspd += speed_vwall_inc
    }
    else
    {
        ang = ang_hwall
        datspd += speed_vwall_inc+2
    }
    
    vinc = trigy(datspd,ang)
    hinc = trigx(datspd,ang)
    
    vsp = vinc/mass*varRead("speed_multiplier")
    jumping = true
    hsp = hinc/mass*varRead("speed_multiplier")
    
    bail_slide_timer = 0
    wall_delay = wall_delay_max
    slide_right = 0
    varSub("myY",30)
    sprite_index = spr_player
    animation_walk()
    exit
}

if slide_left = 1
{
    update_physics = true
    
    if not is_bot(id)
        audio(snd_jump,1)
        
    var vinc = 0
    var hinc = 0
    var ang = 0
    var datspd = speed_jump
    
    if input_check(mapped_control(C_MOVE_RIGHT))
    {
        ang = ang_vwall
        datspd += speed_vwall_inc
    }
    else
    {
        ang = ang_hwall
        datspd += speed_vwall_inc+2
    }
    
    vinc = trigy(datspd,ang)
    hinc = -1*trigx(datspd,ang)
    
    vsp = vinc/mass*varRead("speed_multiplier")
    jumping = true
    hsp = hinc/mass*varRead("speed_multiplier")
    
    bail_slide_timer = 0
    wall_delay = wall_delay_max
    slide_left = 0
    varSub("myY",30)
    sprite_index = spr_player
    animation_walk()
    exit
}
