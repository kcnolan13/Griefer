///roll_dice()
var bpart_spr = false
var prob_item = 0.75

printf("DICE ROLL")
var temp = random(1)
override = false
if temp > prob_item
{
    if random(1) > 0.5
    {
        printf("      slot needs < "+string(prob_item)+", rolled: "+string(temp))
        printf("  --no item in this slot")
        return false
    }
    else
    {
        override = true
    }
}

var rar = random(1)
var rar_index = -1

if not instance_exists(net_manager.my_doll)
{
    printf("ERROR: unable to find your avatar")
    return false
}

if not is_bot(id)
    rar = step_rand(rar,objVarRead(net_manager.my_doll,"rank"))
else
    rar = step_rand(rar,varRead("rank"))

if rar < global.prob_rarity[5]
  rar_index = 5
else if rar < global.prob_rarity[4]
  rar_index = 4
else if rar < global.prob_rarity[0]
  rar_index = 0
else if rar < global.prob_rarity[3]
  rar_index = 3
else if rar < global.prob_rarity[2]
    rar_index = 2
else if rar < global.prob_rarity[1]
    rar_index = 1
    
if override
    rar_index = 1

if rar_index = -1
{
    printf("ERROR: failed to resolve rarity index")
    return false
}
    
printf("   rarity roll: "+string(rar)+", Rarity Index: "+string(rar_index))


var iterations = 0
while (iterations < 500 and not bpart_spr)
{
    iterations ++
    if iterations > 400
        printf("ERROR: taking too long to roll dice")
        
    var rando_spr = floor(random_range(spr_armor_placeholder1+1,spr_armor_placeholder2-0.1))
    var rarity_candidate = bpart_lookup(rando_spr, global.BPART_RARITY)
    var rando_src = bpart_lookup(rando_spr, global.BPART_SOURCE)
    if rarity_candidate = rar_index and (object_index != net_manager or rando_src = global.src_lotto or rando_src = global.src_challenge)
    {
        printf("      --SELECTED sprite: "+string(rando_spr)+" : "+string(bpart_lookup(rando_spr, global.BPART_NAME)))
        return rando_spr
    }
}