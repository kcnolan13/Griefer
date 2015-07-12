///instantiate_all_bots(num_bots)
var num_bots = argument0

printf("ERROR (not): INSTANTIATING "+string(num_bots)+" bots")

//THIS WHOLE ALGORITHM BASICALLY DOESN'T MATTER ANYMORE -- SHUFFLE LOGIC IN AVATAR STEP IS WHAT REALLY MATTERS

var avg_rank = floor(global.num_ranks/2)
var points = floor(random_range(avg_rank*num_bots*2/3,avg_rank*num_bots*3/2))

for (var i=0; i<num_bots; i++)
{
    //select uniqueID
    var pnum = instance_number(avatar)
    
    //select name and rank
    var name = string(generate_name(0.01))
    
    if not instance_exists(myAvatar())
    {
        printf("ERROR: cannot instantiate_all_bots --> no myAvatar() to cross-check name hashes with")
        return false
    }
    
    if hash_string(name) = objVarRead(myAvatar(),"uniqueId")
    {
        while (hash_string(name) = objVarRead(myAvatar(),"uniqueId"))
        {
            name = string(generate_name(0.01))
        }
    }
    
    var rank = floor(max(0,min(random_range(0,global.num_ranks-1),global.num_ranks-1)))
    
    if random(1) < 0.5
        rank = floor(rank/2)
    
    if rank > global.num_ranks - 10 and random(1) < 0.5
        rank -= 15
        
    if rank < 5 and random(1) < 0.5
        rank += 5
        
    points -= rank
    
    var global_rank = 99999
    
    ID = instance_create(room_width/2,-4*room_height,avatar)
    
    objVarWrite(ID,"bot",true)
    objVarWrite(ID,"uniqueId",hash_string(name))
    objVarWrite(ID,"pNum",pnum)
    objVarWrite(ID,"pName",name)
    objVarWrite(ID,"rank",rank)
    objVarWrite(ID,"global_rank",global_rank)
    
    with ID
    {
        shuffling = shuffling_max+shuffling_toff*(varRead("pNum")-1)
    }
    
    printf(objVarRead(ID,"pName")+" IN DA HOOUUSE")
    
    same_armor_probability = random_range(0,1.5)
    armor_set = armor_set_diceroll(rank)
    
    //select some gear for the bot to wear
    for (var j=0; j<array_length_1d(global.bpart_limb_types); j++)
    {
        var new_limb
        
        if j=4 and random(1) > 0.15+rank/array_length_1d(global.rank_names)
            new_limb = spr_hat
        else
        {
        
            var sameprob = same_armor_probability
            if j=0
                sameprob = sameprob/6
        
            if random(1) < sameprob and j < 8
                new_limb = armor_set_limb(armor_set,global.bpart_limb_types[j]) 
            else
                new_limb = random_diceroll_limbtype(global.bpart_limb_types[j])
        }
        
        objVarWrite(ID,global.bpart_limb_types[j]+"0",new_limb)
        printf(string(objVarRead(ID,"pName"))+"'s "+string(global.bpart_limb_types[j])+"0 = "+string(objVarRead(ID,global.bpart_limb_types[j]))+"0") 
    }
    
}
