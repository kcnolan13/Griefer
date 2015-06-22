///instance_destroy_for_everyone(obj)
obj = argument0

if instance_exists(obj)
{
    //send an update with the instance destroy flag
    obj_update_real(obj,"die mothafucka!!",FL_INSTANCE_DESTROY)
    
    //destroy the local copy
    with (obj) 
    {
        instance_destroy()
        exit
    }
    
    if (obj) = id 
    {
        //exit the current event... or at least try(?)
        exit
    }
    
    return true
}
else return false