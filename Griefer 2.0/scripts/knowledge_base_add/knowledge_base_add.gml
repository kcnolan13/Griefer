/// @description bparts_map_add(sprite_index, name, rarity, icon_scale, stealable, source, limb_type)
/// @function bparts_map_add
/// @param sprite_index
/// @param  name
/// @param  rarity
/// @param  icon_scale
/// @param  stealable
/// @param  source
/// @param  limb_type
var sprite = argument0
var name = argument1
var rarity = argument2
var scale = argument3
var stealable = argument4
var source = argument5
var limb_type = argument6
{
    myList[global.BPART_SPRITE] = sprite
    myList[global.BPART_NAME] = name
    myList[global.BPART_RARITY] = rarity
    myList[global.BPART_SCALE] = scale
    myList[global.BPART_STEALABLE] = stealable
    myList[global.BPART_SOURCE] = source
    myList[global.BPART_LIMB_TYPE] = limb_type
    
    if SUPER_DEBUG
    {
        printf("creating bpart")
        str_list = ""
            for (var i=0; i< global.BPARTS_NUM_STORED; i++)
            {
                str_list += "    "+myList[i]
            }
        printf(str_list)
    }
    
    for (var j=0; j<global.BPARTS_NUM_STORED; j++)
    {
        global.knowledge_base[sprite,j] = myList[j]
    }
	
	//hat_xoff
	global.hat_offsets[sprite,0] = 0
	//hat_yoff
	global.hat_offsets[sprite,1] = 0
	//rot
	global.hat_offsets[sprite,2] = 0
	
}