/// @description lookup_limb_type_name(limb_type)
/// @function lookup_limb_type_name
/// @param limb_type
var limb_type = argument0

switch (limb_type)
{
    case "helmet":
        return global.bpart_names[0]
    break
    
    case "torso":
        return global.bpart_names[1]
    break
    
    case "leg":
        return global.bpart_names[2]
    break
    
    case "shin":
        return global.bpart_names[3]
    break
    
    case "hat":
        return global.bpart_names[4]
    break
    
    case "shoulder":
        return global.bpart_names[5]
    break
    
    case "forearm":
        return global.bpart_names[6]
    break
    
    case "foot":
        return global.bpart_names[7]
    break
    
    case "prop":
        return global.bpart_names[8]
    break
}

return "error"