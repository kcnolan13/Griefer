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

if not instance_exists(net_manager.my_doll)
{
    printf("ERROR: unable to find your avatar")
    return false
}

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

var iterations = 0
var rando_spr = spr_none

while (iterations < 500 and not bpart_spr)
{
    iterations ++
    var rando_spr = floor(random_range(spr_armor_placeholder1+1,spr_armor_placeholder2-0.1))
    var rarity_candidate = bpart_lookup(rando_spr, global.BPART_RARITY)
    var rando_src = bpart_lookup(rando_spr, global.BPART_SOURCE)
    if rarity_candidate = rar_index and (object_index != net_manager or rando_src = global.src_lotto /*or rando_src = global.src_challenge*/)
    {
        printf("      --SELECTED sprite: "+string(rando_spr)+" : "+string(bpart_lookup(rando_spr, global.BPART_NAME)))
        return rando_spr
    }
}

if iterations > 499
    printf("ERROR: roll_dice took too long to roll dice")

return rando_spr
