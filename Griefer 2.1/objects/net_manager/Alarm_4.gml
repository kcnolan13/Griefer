/// @description test bparts knowledge base

//printf("Checking Knowledge Base Integrity...")


//no longer performing integrity checks
bparts_map_corrupted = false
return


bparts_map_corrupted = false

for (var i=0; i<array_height_2d(global.knowledge_base); i++)
{
    if (array_length_2d(global.knowledge_base,i) < global.BPARTS_NUM_STORED) or string(global.knowledge_base[i,global.BPART_NAME]) = "-1"
    {
        if (i < spr_armor_placeholder2 or i > spr_weapon_placeholder1)
        {
            //clear out the knowledge base and reimport
            bparts_map_corrupted = true
            printf("Checking Knowledge Base Integrity...")
            printf("----CORRUPTION FOUND: ")
            var str = "sprite #"+string(i)+": "
            for (var j=0; j<array_length_2d(global.knowledge_base,i); j++)
            {
                str += global.knowledge_base[i,j]+", "
            }
            printf(str)
            break
        }
    }
}

if bparts_map_corrupted
{
    print_knowledge_base()
    printf("CLEARING KNOWLEDGE BASE")
    clear_knowledge_base()
    print_knowledge_base()
    printf("REPOPULATING KNOWLEDGE BASE")
    populate_bpart_knowledge_base()
    print_knowledge_base()
    bparts_map_corrupted = false
}
else
{
    if DEBUG
        printf("knowledge base intact")
}

alarm[4] = 30*5

