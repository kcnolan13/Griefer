if not varRead("controllable") or varRead("speed_multiplier") < 0.2 or in_snare(id) return false


if not jumping and (collision_rectangle(bbox_left,bbox_top,bbox_right,bbox_bottom+32,block,true,true) or collision_rectangle(bbox_left,bbox_top,bbox_right,bbox_bottom+32,block2_top,true,true) or standing_2way = true)
{
    if net_manager.local_player = id
    audio_play_sound(snd_jump,2,false)
    
            if crawling = 0 and rolling = 0
            {
                vsp = -32/mass*varRead("speed_multiplier")
                //audio_play_sound_at(snd_jump,0,0,0,300,800,1,false,4)
                jumping = true
                exit
            }
            else
            if !collision_rectangle(bbox_left+10,bbox_top-64,bbox_right-10,bbox_bottom-10,block,true,true)
            {
                crawling = 0
                varSub("myY",41)
                vsp = -32/mass*varRead("speed_multiplier")
                //audio_play_sound_at(snd_jump,0,0,0,300,800,1,false,4)
                jumping = true
            }
} /*else if can_djump = 1 and slide_right = 0 and slide_left = 0 {
            can_djump = 0
            vsp = -25/mass
            audio_play_sound_at(snd_jump,0,0,0,300,800,1,false,4)
            jumping = true
            exit
}*/
    
if slide_right = 1
{
if not is_bot(id)
    audio_play_sound(snd_jump,2,false)
vsp = -32/mass*varRead("speed_multiplier")
jumping = true
hsp = 6/mass*varRead("speed_multiplier")
slide_right = 0
varSub("myY",30)
sprite_index = spr_player
animation_walk()
exit
}

if slide_left = 1
{
if not is_bot(id)
    audio_play_sound(snd_jump,2,false)
vsp = -32/mass*varRead("speed_multiplier")
jumping = true
hsp = -6/mass*varRead("speed_multiplier")
slide_left = 0
varSub("myY",30)
sprite_index = spr_player
animation_walk()
exit
}