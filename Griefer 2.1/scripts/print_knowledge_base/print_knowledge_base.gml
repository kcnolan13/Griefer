/// @description clear_knowledge_base()
/// @function clear_knowledge_base
printf("")

printf("CURRENT BPART KNOWLEDGE BASE:")
for (var i=0; i<array_height_2d(global.knowledge_base); i++)
{
    var linestr = ""
    for (var j=0; j<array_length_2d(global.knowledge_base,i); j++)
    {
        linestr += string(global.knowledge_base[i,j])
        if j<array_length_2d(global.knowledge_base,i)-1 linestr+=": "
    }
    printf(linestr)
}

printf("")