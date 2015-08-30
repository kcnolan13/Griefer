///bparts_all_ready()
//TO BE CALLED FROM NET_MANAGER ONLY
for (var i=0; i<NUM_BPARTS; i++)
{
    if not bparts_ready[i]
    {
        if DEBUG
            printf("bparts with index "+i+" are NOT ready")
            
        return false
    }
}
return true
