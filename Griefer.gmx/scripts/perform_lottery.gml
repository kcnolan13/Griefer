///perform_lottery()
if DEBUG
    printf("performing lottery...")
    
//3 attempts to get gear, one for each prospective slot
for (var i=0; i<3; i++)
{
    var loops = 0
    var cand = roll_dice()
    if cand
    {
        while (bpart_has(cand) and loops < 10)
        {
            loops ++
            cand = roll_dice()
        }
        
        printf("LOTTERY ITEM: "+string(cand))
        new_bpart = instantiate_bpart(cand,global.src_lotto,global.cache)
        new_bpart.new = true
        net_manager.bpart_lotto[i] = new_bpart
    }
}

net_manager.lotto_ready = true