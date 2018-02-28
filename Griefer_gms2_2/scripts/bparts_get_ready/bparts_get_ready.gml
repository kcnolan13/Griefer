/// @description bparts_get_ready(bpart_index)
/// @function bparts_get_ready
/// @param bpart_index
bpart_index = argument0

if string(varRead("helmet"+string(bpart_index))) != "" and string(varRead("torso"+string(bpart_index))) != ""
and string(varRead("leg"+string(bpart_index))) != "" and string(varRead("shin"+string(bpart_index))) != ""
and string(varRead("foot"+string(bpart_index))) != "" and string(varRead("hat"+string(bpart_index))) != ""
and string(varRead("shoulder"+string(bpart_index))) != "" and string(varRead("forearm"+string(bpart_index))) != "" and string(varRead("prop"+string(bpart_index))) != ""
{
    if DEBUG
        printf("readying bparts with index "+string(bpart_index))
        
    varWrite("helmet"+string(bpart_index)+"_src",bpart_extract_source(varRead("helmet"+string(bpart_index))))
    varWrite("helmet"+string(bpart_index),bpart_extract_sprite(varRead("helmet"+string(bpart_index))))
    
    varWrite("torso"+string(bpart_index)+"_src",bpart_extract_source(varRead("torso"+string(bpart_index))))
    varWrite("torso"+string(bpart_index),bpart_extract_sprite(varRead("torso"+string(bpart_index))))
    
    varWrite("leg"+string(bpart_index)+"_src",bpart_extract_source(varRead("leg"+string(bpart_index))))
    varWrite("leg"+string(bpart_index),bpart_extract_sprite(varRead("leg"+string(bpart_index))))
    
    if DEBUG printf("leg"+string(bpart_index)+" = "+varRead("leg"+string(bpart_index)))
    
    varWrite("shin"+string(bpart_index)+"_src",bpart_extract_source(varRead("shin"+string(bpart_index))))
    varWrite("shin"+string(bpart_index),bpart_extract_sprite(varRead("shin"+string(bpart_index))))
    
    varWrite("foot"+string(bpart_index)+"_src",bpart_extract_source(varRead("foot"+string(bpart_index))))
    varWrite("foot"+string(bpart_index),bpart_extract_sprite(varRead("foot"+string(bpart_index))))
    
    if DEBUG printf("foot"+string(bpart_index)+" = "+varRead("foot"+string(bpart_index)))
    
    varWrite("hat"+string(bpart_index)+"_src",bpart_extract_source(varRead("hat"+string(bpart_index))))
    varWrite("hat"+string(bpart_index),bpart_extract_sprite(varRead("hat"+string(bpart_index))))
    
    if DEBUG
        printf("hat"+string(bpart_index)+" = "+varRead("hat"+string(bpart_index)))
    
    varWrite("shoulder"+string(bpart_index)+"_src",bpart_extract_source(varRead("shoulder"+string(bpart_index))))
    varWrite("shoulder"+string(bpart_index),bpart_extract_sprite(varRead("shoulder"+string(bpart_index))))
    
    varWrite("forearm"+string(bpart_index)+"_src",bpart_extract_source(varRead("forearm"+string(bpart_index))))
    varWrite("forearm"+string(bpart_index),bpart_extract_sprite(varRead("forearm"+string(bpart_index))))
    
    varWrite("prop"+string(bpart_index)+"_src",bpart_extract_source(varRead("prop"+string(bpart_index))))
    varWrite("prop"+string(bpart_index),bpart_extract_sprite(varRead("prop"+string(bpart_index))))
    
    if DEBUG printf("prop"+string(bpart_index)+" = "+varRead("prop"+string(bpart_index)))
    
    return true
} else return false