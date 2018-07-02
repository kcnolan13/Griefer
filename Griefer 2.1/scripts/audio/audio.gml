/// @description audio(sound,falloff_scaler)
/// @function audio
/// @param sound
/// @param falloff_scaler
var sound = argument0
var falloff = argument1*GAIN_AUDIO

var snd = audio_play_sound(sound,falloff,false)
//printf("::: gain BEFORE for "+string(sound_get_name(sound))+" = "+string(audio_sound_get_gain(snd)))
audio_sound_gain(snd,falloff*audio_sound_get_gain(snd),0)
//printf("::: gain AFTER for "+string(sound_get_name(sound))+" = "+string(audio_sound_get_gain(snd)))

var ref_norm = __view_get( e__VW.WView, 0 )*2/3
var playx = x
var playy = y

if instance_exists(net_manager.local_player) and objVarRead(net_manager.local_player,"alive")
{
    playx = (x - net_manager.local_player.x)
    playy = (y - net_manager.local_player.y)
}
//audio_play_sound_at(sound,0,point_distance(0,0,playx,playy),0,ref_norm*falloff,3*1024,25,false,3*falloff)
