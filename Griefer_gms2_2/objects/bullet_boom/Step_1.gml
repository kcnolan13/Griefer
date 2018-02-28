/// @description burst particles and play sound and create trail muzzle flash

event_inherited()

if not audio_is_playing(snd_boom_fly) and inside_room(id)
    audio(snd_boom_fly,1)
    
if net_manager.local_player = find_player(varRead("senderId"))
{
    obj_update_real(id,"myX",FL_NORMAL)
    obj_update_real(id,"myY",FL_NORMAL)
}

//create header muzzle flash
/*myFlash = instance_create(x,y,flash_boom_flying)
angle = point_direction(xprevious,yprevious,x,y)
objVarWrite(myFlash,"angle",angle)*/



/* */
/*  */
