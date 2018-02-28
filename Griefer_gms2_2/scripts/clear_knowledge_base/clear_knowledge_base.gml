/// @description clear_knowledge_base()
/// @function clear_knowledge_base
printf("    clearing out knowledge_base for a fresh start...")
for (var i=0; i<spr_armor_placeholder2; i++)
{
    for (var j=0; j<global.BPARTS_NUM_STORED; j++)
    {
        //if i=16 printf("setting global.knowledge_base["+i+","+j+"] = "+global.bpart_empty)
        global.knowledge_base[i,j] = global.bpart_empty
    }
}