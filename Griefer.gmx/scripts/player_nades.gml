///player_nades(player_object)
var player_obj = argument0
var candidate = objVarRead(player_obj,"weapon3")

if instance_exists(candidate)
{
    if objVarRead(candidate,"is_nade")
    {
        return candidate
    } else 
    {
        if DEBUG
        printf("quicktoss candidate is not nades")
        
        return noone
    }
    
} else
{
    if DEBUG
        printf("quicktoss candidate does not exist")
        
    return noone
}