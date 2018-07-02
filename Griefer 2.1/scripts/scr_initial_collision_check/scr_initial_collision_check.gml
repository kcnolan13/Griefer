//collision checking

if place_meeting(x,y,block) || place_meeting(x,y,block2_top)
    event_perform(ev_collision,block)
    
if instance_place(x,y,player)
{   
    ID = instance_place(x,y,player)
    ID.override_id = object_index
    with (ID) event_perform(ev_collision,override_id)
}//end collision checking