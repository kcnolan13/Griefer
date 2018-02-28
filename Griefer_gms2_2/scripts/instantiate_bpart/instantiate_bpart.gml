/// @description instantiate_bpart(sprite_index, source, destination_list)
/// @function instantiate_bpart
/// @param sprite_index
/// @param  source
/// @param  destination_list
var spr = argument0
var src = argument1
var dest_list = argument2
{
    if SUPER_DEBUG
        printf("    instantiating body part...")
        
    ID = instance_create(x,y,bpart_generic)
    ID.icon = spr
    ID.name = bpart_lookup(spr, global.BPART_NAME)
    ID.rarity = bpart_lookup(spr, global.BPART_RARITY)
    ID.icon_scale = bpart_lookup(spr, global.BPART_SCALE)
    ID.stealable = bpart_lookup(spr, global.BPART_STEALABLE)
    ID.limb_type = bpart_lookup(spr, global.BPART_LIMB_TYPE)
    
    if (string(src) = global.src_challenge)
        ID.source = bpart_lookup(spr, global.BPART_SOURCE)
    else
        ID.source = src
        
    if ds_exists(dest_list,ds_type_list)
    {
        //manage_cache after a short delay
        net_manager.alarm[11] = 35
        ds_list_add(dest_list,ID)
        
        if SUPER_DEBUG
        {
            var ind = ds_list_size(dest_list)-1
            var pt = dest_list[| ind]
            printf("added: "+pt.name+" : to one of the DS lists")
        }
    } else {
        printf("ERROR: couldn't instantiate body part: bad destination list")
        return false
    }
        
    //if DEBUG
    {
        //if SUPER_DEBUG
            //printf("INSTANTIATED BODY PART:")
        printf("        instantiate: "+string(ID.name)+" : "+string(ID.limb_type)+" : "+"spr="+string(ID.icon)+", rar="+string(ID.rarity)+", scal="+string(ID.icon_scale)+", steal="+string(ID.stealable)+", src="+string(ID.source))
    }
    
    return ID
}
