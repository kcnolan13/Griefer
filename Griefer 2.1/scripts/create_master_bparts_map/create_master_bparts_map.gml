/// @description create_master_bparts_map
global.hatless = ds_list_create()

global.src_lotto = "Armor Lottery" //will the space break anything?
global.src_challenge = "Challenge"
global.src_default = "default"
global.src_empty = "empty"
global.default_name = "Basic"
global.src_disabled = "youz_disabled"
global.disabled_name = "handicapped_parking_only"

global.spr_empty = "9999"

global.bpart_limb_types[0] = "helmet"
global.bpart_limb_types[1] = "torso"
global.bpart_limb_types[2] = "leg"
global.bpart_limb_types[3] = "shin"
global.bpart_limb_types[4] = "hat"
global.bpart_limb_types[5] = "shoulder"
global.bpart_limb_types[6] = "forearm"
global.bpart_limb_types[7] = "foot"
global.bpart_limb_types[8] = "prop"

global.default_hat = spr_hat
global.default_helmet = spr_head
global.default_torso = spr_torso
global.default_leg = spr_leg
global.default_shin = spr_shin
global.default_foot = spr_foot
global.default_shoulder = spr_shoulder
global.default_forearm = spr_forearm
global.default_prop = spr_prop

global.default_scale = PLAYER_SCALE

global.BPART_SPRITE = 0
global.BPART_NAME = 1
global.BPART_RARITY = 2
global.BPART_SCALE = 3
global.BPART_STEALABLE = 4
global.BPART_SOURCE = 5
global.BPART_LIMB_TYPE = 6      //hat, helmet, torso, leg, shin, foot, shoulder, forearm

global.BPARTS_NUM_STORED = 7

global.slot_alpha = 1

//RARITY PROPERTIES
rarity_properties()

//establish weapon names
global_weapon_properties()

global.bpart_names[0] = "Head"
global.bpart_names[1] = "Chest"
global.bpart_names[2] = "Thigh"
global.bpart_names[3] = "Shin"
global.bpart_names[4] = "Hat"
global.bpart_names[5] = "Shoulder"
global.bpart_names[6] = "Forearm"
global.bpart_names[7] = "Foot"
global.bpart_names[8] = "Prop"

global.bpart_empty = -53

printf("")
printf("")
printf("Loading Body Part Knowledge Base Into Memory ...")

clear_knowledge_base() 
populate_bpart_knowledge_base()
print_knowledge_base()

























printf("")
printf("")