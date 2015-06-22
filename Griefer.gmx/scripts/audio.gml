///audio(sound,falloff_scaler)
var sound = argument0
var falloff = argument1

var ref_norm = view_wview*2/3

var playx = x
var playy = y

if instance_exists(net_manager.local_player) and objVarRead(net_manager.local_player,"alive")
{
    playx = (x - net_manager.local_player.x)
    playy = (y - net_manager.local_player.y)
}
audio_play_sound(sound,falloff,false)
//audio_play_sound_at(sound,0,point_distance(0,0,playx,playy),0,ref_norm*falloff,3*1024,25,false,3*falloff)