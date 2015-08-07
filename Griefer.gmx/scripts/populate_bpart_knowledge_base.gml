///populate_bpart_knowledge_base()
printf("")
printf("POPULATING KNOWLEDGE BASE")
printf("")

//default gear --> all pieces get default name??
knowledge_base_add(spr_head, global.default_name, 0, global.default_scale, false, global.src_default,"helmet")
knowledge_base_add(spr_torso, global.default_name, 0, global.default_scale, false, global.src_default,"torso")
knowledge_base_add(spr_leg, global.default_name, 0, global.default_scale, false, global.src_default,"leg")
knowledge_base_add(spr_shin, global.default_name, 0, global.default_scale, false, global.src_default,"shin")
knowledge_base_add(spr_hat, global.default_name, 0, global.default_scale, false, global.src_default,"hat")
knowledge_base_add(spr_shoulder, global.default_name, 0, global.default_scale, false, global.src_default,"shoulder")
knowledge_base_add(spr_forearm, global.default_name, 0, global.default_scale, false, global.src_default,"forearm")
knowledge_base_add(spr_foot, global.default_name, 0, global.default_scale, false, global.src_default,"foot")
knowledge_base_add(spr_prop, global.default_name, 0, global.default_scale, false, global.src_default,"prop")

//none sprite types -- used for disabled slots
knowledge_base_add(spr_helmet_none, global.disabled_name, 0, global.default_scale, false, global.src_disabled,"helmet")
knowledge_base_add(spr_torso_none, global.disabled_name, 0, global.default_scale, false, global.src_disabled,"torso")
knowledge_base_add(spr_leg_none, global.disabled_name, 0, global.default_scale, false, global.src_disabled,"leg")
knowledge_base_add(spr_shin_none, global.disabled_name, 0, global.default_scale, false, global.src_disabled,"shin")
knowledge_base_add(spr_hat_none, global.disabled_name, 0, global.default_scale, false, global.src_disabled,"hat")
knowledge_base_add(spr_shoulder_none, global.disabled_name, 0, global.default_scale, false, global.src_disabled,"shoulder")
knowledge_base_add(spr_forearm_none, global.disabled_name, 0, global.default_scale, false, global.src_disabled,"forearm")
knowledge_base_add(spr_foot_none, global.disabled_name, 0, global.default_scale, false, global.src_disabled,"foot")
knowledge_base_add(spr_prop_none, global.disabled_name, 0, global.default_scale, false, global.src_disabled,"prop")

//weapon props
knowledge_base_add(spr_pistol, global.pistol, 1, scale_2icon(spr_pistol), false, global.src_challenge,"prop")
knowledge_base_add(spr_rifle, global.rifle, 1, scale_2icon(spr_rifle), false, global.src_challenge,"prop")
knowledge_base_add(spr_shotgun, global.shotgun, 2, scale_2icon(spr_shotgun), false, global.src_challenge,"prop")
knowledge_base_add(spr_frag, global.frag, 2, scale_2icon(spr_frag), false, global.src_challenge,"prop")
knowledge_base_add(spr_flashbang, global.flashbang, 1, scale_2icon(spr_flashbang), false, global.src_challenge,"prop")
knowledge_base_add(spr_smoke, global.smoke, 1, scale_2icon(spr_smoke), false, global.src_challenge,"prop")
knowledge_base_add(spr_lmg, global.lmg, 3, scale_2icon(spr_lmg), false, global.src_challenge,"prop")
knowledge_base_add(spr_smg, global.smg, 2, scale_2icon(spr_smg), false, global.src_challenge,"prop")
knowledge_base_add(spr_longshot, global.longshot, 3, scale_2icon(spr_longshot), false, global.src_challenge,"prop")
knowledge_base_add(spr_vulcan, global.vulcan, 3, scale_2icon(spr_vulcan), false, global.src_challenge,"prop")
knowledge_base_add(spr_boom, global.boom, 3, scale_2icon(spr_boom), false, global.src_challenge,"prop")
knowledge_base_add(spr_boltok, global.boltok, 2, scale_2icon(spr_boltok), false, global.src_challenge,"prop")
knowledge_base_add(spr_ink, global.ink, 2, scale_2icon(spr_ink), false, global.src_challenge,"prop")
knowledge_base_add(spr_sticky, global.sticky, 2, scale_2icon(spr_sticky), false, global.src_challenge,"prop")
knowledge_base_add(spr_torque, global.torque, 3, scale_2icon(spr_torque), false, global.src_challenge,"prop")
knowledge_base_add(spr_rocket, global.rocket, 3, scale_2icon(spr_rocket), false, global.src_challenge,"prop")
knowledge_base_add(spr_double, global.double, 3, scale_2icon(spr_double), false, global.src_challenge,"prop")
knowledge_base_add(spr_stomper, global.stomper, 3, scale_2icon(spr_stomper), false, global.src_challenge,"prop")
knowledge_base_add(spr_snare, global.snare, 2, scale_2icon(spr_snare), false, global.src_challenge,"prop")
knowledge_base_add(spr_flame, global.flame, 2, scale_2icon(spr_flame), false, global.src_challenge,"prop")
knowledge_base_add(spr_carbine, global.carbine, 2, scale_2icon(spr_carbine), false, global.src_challenge,"prop")
knowledge_base_add(spr_tickler, global.tickler, 2, scale_2icon(spr_tickler), false, global.src_challenge,"prop")
knowledge_base_add(spr_thumper, global.thumper, 3, scale_2icon(spr_thumper), false, global.src_challenge,"prop")

//helmets
knowledge_base_add(spr_eva_helmet, "Eva", 2, global.default_scale, true, global.src_lotto,"helmet")
knowledge_base_add(spr_basic_helmet, "Standard Issue", 1, global.default_scale, true, global.src_lotto,"helmet")
knowledge_base_add(spr_boxer_helmet, "Boxer Helmet", 2, global.default_scale, true, global.src_lotto,"helmet")
knowledge_base_add(spr_scanner_helmet, "Scanner Helmet", 2, global.default_scale, true, global.src_lotto,"helmet")
knowledge_base_add(spr_breather_helmet, "Rebreather Helmet", 1, global.default_scale, true, global.src_lotto,"helmet")
knowledge_base_add(spr_exgol_helmet, "Exgol Helmet", 1, global.default_scale, true, global.src_lotto,"helmet")
knowledge_base_add(spr_grenadier_helmet, "Gol Grenadier Helmet", 1, global.default_scale, true, global.src_lotto,"helmet")
knowledge_base_add(spr_wraith_helmet, "Wraith Helmet", 1, global.default_scale, true, global.src_lotto,"helmet")
knowledge_base_add(spr_ahunch_helmet, "War Mongrel", 5, global.default_scale, true, global.src_challenge,"helmet")
    set_hatless(spr_ahunch_helmet)
knowledge_base_add(spr_bhunch_helmet, "Hell Hound", 5, global.default_scale, true, global.src_challenge,"helmet")
    set_hatless(spr_bhunch_helmet)
global.mantel2_name = "Variant Helmet"
knowledge_base_add(spr_mantel2_helmet, global.mantel2_name, 3, global.default_scale, true, global.src_lotto,"helmet")
knowledge_base_add(spr_mantel_helmet, "Mantel Helmet", 3, global.default_scale, true, global.src_lotto,"helmet")
global.dred_name = "Dread Helmet"
knowledge_base_add(spr_dred_helmet, global.dred_name, 4, global.default_scale, true, global.src_challenge,"helmet")
global.tadpole_name = "Tadpole Helmet"
knowledge_base_add(spr_tadpole_helmet, global.tadpole_name, 3, global.default_scale, true, global.src_challenge,"helmet")

global.emile2_name = "Support Helmet"
knowledge_base_add(spr_emile2_helmet, global.emile2_name, 2, global.default_scale, true, global.src_lotto,"helmet")

knowledge_base_add(spr_emile_helmet, "Eva Helmet", 2, global.default_scale, true, global.src_lotto,"helmet")
knowledge_base_add(spr_hound_helmet, "Hound Helmet", 3, global.default_scale, true, global.src_challenge,"helmet")
global.hound2_name = "Black Hound Helmet"
knowledge_base_add(spr_hound2_helmet, global.hound2_name, 4, global.default_scale, true, global.src_challenge,"helmet")
    set_hatless(spr_hound_helmet)
    set_hatless(spr_hound2_helmet)
global.fanatic_name = "Fanatic Helmet"
knowledge_base_add(spr_rvisor2_helmet, global.fanatic_name, 4, global.default_scale, true, global.src_challenge,"helmet")
global.pvisor_name = "Deadshot Helmet"
knowledge_base_add(spr_pvisor_helmet, "Pvisor Helmet", 3, global.default_scale, true, global.src_challenge,"helmet")
global.pvisor2_name = "Headhunter Helmet"
knowledge_base_add(spr_pvisor2_helmet, global.pvisor2_name, 3, global.default_scale, true, global.src_challenge,"helmet")
global.roman_name = "Roman Helmet"
knowledge_base_add(spr_roman_helmet, global.roman_name, 4, global.default_scale, true, global.src_challenge,"helmet")
    set_hatless(spr_roman_helmet)
global.smallvisor2_name = "Gravemaker Helmet"
knowledge_base_add(spr_smallvisor_helmet, "Smallvisor Helmet", 2, global.default_scale, true, global.src_lotto,"helmet")
knowledge_base_add(spr_smallvisor2_helmet, global.smallvisor2_name, 3, global.default_scale, true, global.src_challenge,"helmet")

knowledge_base_add(spr_pyramid_helmet, "Pyramid Head", 4, global.default_scale, true, global.src_challenge,"helmet")
    set_hatless(spr_pyramid_helmet)

global.rvisor_name = "Smooth Operator Helmet"
knowledge_base_add(spr_rvisor_helmet, global.rvisor_name, 3, global.default_scale, true, global.src_challenge,"helmet")
global.gashog_name = "Gas Hog Helmet"
knowledge_base_add(spr_gashog_helmet, global.gashog_name, 4, global.default_scale, true, global.src_challenge,"helmet")

//torsos


//legs


//shins
knowledge_base_add(spr_smooth_shin, "Smooth", 1, global.default_scale, true, global.src_lotto,"shin")

//hats
knowledge_base_add(spr_hat2, "Flamingo Hat", 3, global.default_scale, true, global.src_lotto,"hat")
knowledge_base_add(spr_beret_hat, "Beret", 2, global.default_scale, true, global.src_lotto,"hat")
knowledge_base_add(spr_sombrero_hat, "Sombrero", 4, global.default_scale, true, global.src_lotto,"hat")
knowledge_base_add(spr_red_cap_hat, "Fez", 3, global.default_scale, true, global.src_lotto,"hat")
knowledge_base_add(spr_party_hat, "Party Hat", 3, global.default_scale, true, global.src_lotto,"hat")
knowledge_base_add(spr_crown_hat, "Your Highness", 4, global.default_scale, true, global.src_lotto,"hat")
knowledge_base_add(spr_top_hat, "Lincolnator", 3, global.default_scale, true, global.src_lotto,"hat")
knowledge_base_add(spr_tan_brim_hat, "Boater", 3, global.default_scale, true, global.src_lotto,"hat")
knowledge_base_add(spr_black_beanie_hat, "Black Beanie", 2, global.default_scale, true, global.src_lotto,"hat")
knowledge_base_add(spr_military_hat, "Military Cap", 2, global.default_scale, true, global.src_lotto,"hat")
knowledge_base_add(spr_blue_hat, "Classic Blue", 2, global.default_scale, true, global.src_lotto,"hat")
knowledge_base_add(spr_dunce_hat, "Dunce Hat", 0, global.default_scale, true, global.src_lotto,"hat")
knowledge_base_add(spr_admiral_hat, "Admiral Hat", 3, global.default_scale, true, global.src_lotto,"hat")
knowledge_base_add(spr_aviator_hat, "Aviator Hat", 3, global.default_scale, true, global.src_lotto,"hat")
knowledge_base_add(spr_bunny_hat, "Bunny Hat", 0, global.default_scale, true, global.src_lotto,"hat")
knowledge_base_add(spr_santa_hat, "Santa Hat", 4, global.default_scale, true, global.src_challenge,"hat")

//shoulders
knowledge_base_add(spr_zoidberg_shoulder, "Ring Shoulder", 2, global.default_scale, true, global.src_lotto,"shoulder")

//forearms
knowledge_base_add(spr_barbuckle_forearm, "Bar Brace", 1, global.default_scale, true, global.src_lotto,"forearm")
knowledge_base_add(spr_buckle_forearm, "Basic Brace", 1, global.default_scale, true, global.src_lotto,"forearm")
knowledge_base_add(spr_shaft_forearm, "Piston Brace", 1, global.default_scale, true, global.src_lotto,"forearm")
knowledge_base_add(spr_shellshield_forearm, "Buckshot Gauntlet", 2, global.default_scale, true, global.src_lotto,"forearm")
knowledge_base_add(spr_wristguard_forearm, "Wrist Guard", 1, global.default_scale, true, global.src_lotto,"forearm")

//feet
knowledge_base_add(spr_wingboot_foot, "Wing Boot", 1, global.default_scale, true, global.src_lotto,"foot")
knowledge_base_add(spr_bootvariant_foot, "Basic Boot", 1, global.default_scale, true, global.src_lotto,"foot")
knowledge_base_add(spr_elf_foot, "Elf Boot", 2, global.default_scale, true, global.src_lotto,"foot")

//FULL ARMOR SETS

//desert
global.armor_sets[0,0] = spr_desert_helmet
global.src_desert = global.src_lotto
knowledge_base_add(spr_desert_helmet, "Desert", 1, global.default_scale, true, global.src_desert,"helmet")
knowledge_base_add(spr_desert_leg, "Desert", 1, global.default_scale, true, global.src_desert,"leg")
knowledge_base_add(spr_desert_shin, "Desert", 1, global.default_scale, true, global.src_desert,"shin")
knowledge_base_add(spr_displaybuckle_forearm, "GPS Brace", 1, global.default_scale, true, global.src_desert,"forearm")
knowledge_base_add(spr_desert_shoulder, "Desert", 1, global.default_scale, true, global.src_desert,"shoulder")
knowledge_base_add(spr_desert_foot, "Desert", 1, global.default_scale, true, global.src_desert,"foot")
knowledge_base_add(spr_desert_torso, "Desert", 1, global.default_scale, true, global.src_desert,"torso")
global.armor_sets[0,1] = spr_desert_torso

//assassin
global.armor_sets[1,0] = spr_assassin_helmet
global.ass_name = "Executioner"
knowledge_base_add(spr_assassin_helmet, global.ass_name, 3, global.default_scale, true, global.src_challenge,"helmet")
knowledge_base_add(spr_assassin_forearm, global.ass_name, 3, global.default_scale, true, global.src_challenge,"forearm")
knowledge_base_add(spr_assassin_shoulder, global.ass_name, 3, global.default_scale, true, global.src_challenge,"shoulder")
knowledge_base_add(spr_assassin_foot, global.ass_name, 3, global.default_scale, true, global.src_challenge,"foot")
knowledge_base_add(spr_assassin_leg, global.ass_name, 3, global.default_scale, true, global.src_challenge,"leg")
knowledge_base_add(spr_assassin_shin, global.ass_name, 3, global.default_scale, true, global.src_challenge,"shin")
knowledge_base_add(spr_assassin_torso, global.ass_name, 3, global.default_scale, true, global.src_challenge,"torso")
global.armor_sets[1,1] = spr_assassin_torso

//blue
global.armor_sets[2,0] = spr_blue_helmet
global.blue_name = "Blue"
global.src_blue = global.src_lotto
knowledge_base_add(spr_blue_shoulder, global.blue_name, 3, global.default_scale, true, global.src_blue,"shoulder")
knowledge_base_add(spr_blue_leg, global.blue_name, 3, global.default_scale, true, global.src_blue,"leg")
knowledge_base_add(spr_blue_foot, global.blue_name, 3, global.default_scale, true, global.src_blue,"foot")
knowledge_base_add(spr_blue_shin, global.blue_name, 3, global.default_scale, true, global.src_blue,"shin")
knowledge_base_add(spr_blue_torso, global.blue_name, 3, global.default_scale, true, global.src_blue,"torso")
knowledge_base_add(spr_blue_helmet, global.blue_name, 3, global.default_scale, true, global.src_blue,"helmet")
knowledge_base_add(spr_blue_forearm, global.blue_name, 3, global.default_scale, true, global.src_blue,"forearm")
global.armor_sets[2,0] = spr_blue_forearm

//iron
global.armor_sets[3,0] = spr_iron_helmet
global.iron_name = "Iron"
global.src_iron = global.src_challenge
knowledge_base_add(spr_ironboot_foot, global.iron_name, 2, global.default_scale, true, global.src_iron,"foot")
knowledge_base_add(spr_iron_leg, global.iron_name, 2, global.default_scale, true, global.src_iron,"leg")
knowledge_base_add(spr_iron_shin, global.iron_name, 2, global.default_scale, true, global.src_iron,"shin")
knowledge_base_add(spr_iron_forearm, global.iron_name, 2, global.default_scale, true, global.src_iron,"forearm")
knowledge_base_add(spr_iron_shoulder, global.iron_name, 2, global.default_scale, true, global.src_iron,"shoulder")
knowledge_base_add(spr_iron_torso, global.iron_name, 2, global.default_scale, true, global.src_iron,"torso")
knowledge_base_add(spr_iron_helmet, global.iron_name, 2, global.default_scale, true, global.src_iron,"helmet")
global.armor_sets[2,1] = spr_ironboot_foot

//red
global.red_name = "Red"
global.armor_sets[4,0] = spr_red_helmet
global.src_red = global.src_lotto
knowledge_base_add(spr_red_forearm, global.red_name, 3, global.default_scale, true, global.src_challenge,"forearm")
knowledge_base_add(spr_red_shoulder, global.red_name, 3, global.default_scale, true, global.src_challenge,"shoulder")
knowledge_base_add(spr_red_leg, global.red_name, 3, global.default_scale, true, global.src_challenge,"leg")
knowledge_base_add(spr_red_shin, global.red_name, 3, global.default_scale, true, global.src_challenge,"shin")
knowledge_base_add(spr_red_foot, global.red_name, 3, global.default_scale, true, global.src_challenge,"foot")
knowledge_base_add(spr_red_torso, global.red_name, 3, global.default_scale, true, global.src_challenge,"torso")
knowledge_base_add(spr_red_helmet, global.red_name, 3, global.default_scale, true, global.src_challenge,"helmet")
global.armor_sets[4,1] = spr_red_torso

//shield
global.armor_sets[5,0] = spr_shield_helmet
global.src_shield = global.src_lotto
knowledge_base_add(spr_shield_forearm, "Shield", 2, global.default_scale, true, global.src_shield,"forearm")
knowledge_base_add(spr_shield_leg, "Shield", 2, global.default_scale, true, global.src_shield,"leg")
knowledge_base_add(spr_shield_shin, "Shield", 2, global.default_scale, true, global.src_shield,"shin")
knowledge_base_add(spr_shield_foot, "Shield", 2, global.default_scale, true, global.src_shield,"foot")
knowledge_base_add(spr_shield_shoulder, "Shield", 2, global.default_scale, true, global.src_shield,"shoulder")
knowledge_base_add(spr_shield_torso, "Shield", 2, global.default_scale, true, global.src_shield,"torso")
knowledge_base_add(spr_shield_helmet, "Shield", 2, global.default_scale, true, global.src_shield,"helmet")
global.armor_sets[5,1] = spr_shield_torso

//arctic
global.armor_sets[6,0] = spr_arctic_helmet
global.src_arctic = global.src_lotto
knowledge_base_add(spr_arctic_shoulder, "Arctic", 1, global.default_scale, true, global.src_arctic,"shoulder")
knowledge_base_add(spr_arctic_foot, "Arctic", 1, global.default_scale, true, global.src_arctic,"foot")
knowledge_base_add(spr_arctic_shin, "Arctic", 1, global.default_scale, true, global.src_arctic,"shin")
knowledge_base_add(spr_arctic_torso, "Arctic", 1, global.default_scale, true, global.src_arctic,"torso")
knowledge_base_add(spr_arctic_helmet, "Arctic", 1, global.default_scale, true, global.src_arctic,"helmet")
knowledge_base_add(spr_arctic_forearm, "Arctic", 1, global.default_scale, true, global.src_arctic,"forearm")
knowledge_base_add(spr_arctic_leg, "Arctic", 1, global.default_scale, true, global.src_arctic,"leg")
global.armor_sets[6,1] = spr_arctic_leg

//spiral
global.armor_sets[7,0] = spr_spiral_helmet
global.src_spiral = global.src_lotto
knowledge_base_add(spr_spiral_leg, "Spiral", 1, global.default_scale, true, global.src_spiral,"leg")
knowledge_base_add(spr_spiral_shin, "Spiral", 1, global.default_scale, true, global.src_spiral,"shin")
knowledge_base_add(spr_spiral_forearm, "Spiral", 1, global.default_scale, true, global.src_spiral,"forearm")
knowledge_base_add(spr_spiral_shoulder, "Spiral", 1, global.default_scale, true, global.src_spiral,"shoulder")
knowledge_base_add(spr_spiral_torso, "Spiral", 1, global.default_scale, true, global.src_spiral,"torso")
knowledge_base_add(spr_spiral_helmet, "Spiral", 1, global.default_scale, true, global.src_spiral,"helmet")
knowledge_base_add(spr_spiral_foot, "Spiral", 1, global.default_scale, true, global.src_spiral,"foot")
global.armor_sets[7,1] = spr_spiral_torso

//ranger
global.armor_sets[8,0] = spr_ranger_helmet
global.src_ranger = global.src_lotto
knowledge_base_add(spr_ranger_leg, "Ranger", 2, global.default_scale, true, global.src_ranger,"leg")
knowledge_base_add(spr_ranger_shin, "Ranger", 2, global.default_scale, true, global.src_ranger,"shin")
knowledge_base_add(spr_ranger_forearm, "Ranger", 2, global.default_scale, true, global.src_ranger,"forearm")
knowledge_base_add(spr_ranger_torso, "Ranger", 2, global.default_scale, true, global.src_ranger,"torso")
knowledge_base_add(spr_ranger_helmet, "Ranger", 2, global.default_scale, true, global.src_ranger,"helmet")
knowledge_base_add(spr_ranger_shoulder, "Ranger", 2, global.default_scale, true, global.src_ranger,"shoulder")
knowledge_base_add(spr_ranger_foot, "Ranger", 2, global.default_scale, true, global.src_ranger,"foot")
global.armor_sets[8,1] = spr_ranger_foot

//wasp
global.armor_sets[9,0] = spr_bee_helmet
global.src_bee = global.src_challenge
knowledge_base_add(spr_bee_helmet, "Wasp", 3, global.default_scale, true, global.src_bee,"helmet")
knowledge_base_add(spr_bee_foot, "Wasp", 3, global.default_scale, true, global.src_bee,"foot")
knowledge_base_add(spr_bee_torso, "Wasp", 3, global.default_scale, true, global.src_bee,"torso")
knowledge_base_add(spr_bee_leg, "Wasp", 3, global.default_scale, true, global.src_bee,"leg")
knowledge_base_add(spr_bee_shin, "Wasp", 3, global.default_scale, true, global.src_bee,"shin")
knowledge_base_add(spr_wasp_forearm, "Wasp", 3, global.default_scale, true, global.src_bee,"forearm")
knowledge_base_add(spr_wasp_shoulder, "Wasp", 3, global.default_scale, true, global.src_bee,"shoulder")
global.armor_sets[9,1] = spr_bee_shin

//cursed
global.armor_sets[10,0] = spr_cursed_helmet
global.src_cursed = global.src_challenge
knowledge_base_add(spr_cursed_helmet, "Cursed", 4, global.default_scale, true, global.src_cursed,"helmet")
knowledge_base_add(spr_cursed_leg, "Cursed", 4, global.default_scale, true, global.src_cursed,"leg")
knowledge_base_add(spr_cursed_shin, "Cursed", 4, global.default_scale, true, global.src_cursed,"shin")
knowledge_base_add(spr_cursed_foot, "Cursed", 4, global.default_scale, true, global.src_cursed,"foot")
knowledge_base_add(spr_cursed_forearm, "Cursed", 4, global.default_scale, true, global.src_cursed,"forearm")
knowledge_base_add(spr_cursed_torso, "Cursed", 4, global.default_scale, true, global.src_cursed,"torso")
knowledge_base_add(spr_cursed_shoulder, "Cursed", 4, global.default_scale, true, global.src_cursed,"shoulder")
global.armor_sets[10,1] = spr_cursed_shoulder

//beta
global.armor_sets[11,0] = spr_beta_head
global.src_beta = global.src_lotto
knowledge_base_add(spr_beta_head, "Beta", 1, global.default_scale, true, global.src_beta,"helmet")
knowledge_base_add(spr_beta_torso, "Beta", 1, global.default_scale, true, global.src_beta,"torso")
knowledge_base_add(spr_beta_leg, "Beta", 1, global.default_scale, true, global.src_beta,"leg")
knowledge_base_add(spr_beta_shin, "Beta", 1, global.default_scale, true, global.src_beta,"shin")
knowledge_base_add(spr_beta_foot, "Beta", 1, global.default_scale, true, global.src_beta,"foot")
knowledge_base_add(spr_beta_shoulder, "Beta", 1, global.default_scale, true, global.src_beta,"shoulder")
knowledge_base_add(spr_beta_forearm, "Beta", 1, global.default_scale, true, global.src_beta,"forearm")
global.armor_sets[11,1] = spr_beta_forearm

//plague
global.armor_sets[12,0] = spr_plague_helmet
global.plague_name = "Plague Doctor"
global.src_plague = global.src_challenge
knowledge_base_add(spr_plague_helmet, global.plague_name, 2, global.default_scale, true, global.src_plague,"helmet")
knowledge_base_add(spr_plague_shoulder, global.plague_name, 2, global.default_scale, true, global.src_plague,"shoulder")
knowledge_base_add(spr_plague_forearm, global.plague_name, 2, global.default_scale, true, global.src_plague,"forearm")
knowledge_base_add(spr_plague_torso, global.plague_name, 2, global.default_scale, true, global.src_plague,"torso")
knowledge_base_add(spr_plague_foot, global.plague_name, 2, global.default_scale, true, global.src_plague,"foot")
knowledge_base_add(spr_plague_leg, global.plague_name, 2, global.default_scale, true, global.src_plague,"leg")
knowledge_base_add(spr_plague_shin, global.plague_name, 2, global.default_scale, true, global.src_plague,"shin")
global.armor_sets[12,1] = spr_plague_shin

//aroach
global.aroach_name = "Roach"
global.armor_sets[13,0] = spr_aroach_helmet
knowledge_base_add(spr_aroach_forearm, global.aroach_name, 3, global.default_scale, true, global.src_challenge,"forearm")
knowledge_base_add(spr_aroach_shoulder, global.aroach_name, 3, global.default_scale, true, global.src_challenge,"shoulder")
knowledge_base_add(spr_aroach_leg, global.aroach_name, 3, global.default_scale, true, global.src_challenge,"leg")
knowledge_base_add(spr_aroach_shin, global.aroach_name, 3, global.default_scale, true, global.src_challenge,"shin")
knowledge_base_add(spr_aroach_foot, global.aroach_name, 3, global.default_scale, true, global.src_challenge,"foot")
knowledge_base_add(spr_aroach_torso, global.aroach_name, 3, global.default_scale, true, global.src_challenge,"torso")
knowledge_base_add(spr_aroach_helmet, global.aroach_name, 3, global.default_scale, true, global.src_challenge,"helmet")
global.armor_sets[13,1] = spr_aroach_foot

//glow
global.glow_name = "Stasis"
global.armor_sets[14,0] = spr_glow_helmet
global.src_statis = global.src_lotto
knowledge_base_add(spr_glow_forearm, global.glow_name, 4, global.default_scale, true, global.src_statis,"forearm")
knowledge_base_add(spr_glow_shoulder, global.glow_name, 4, global.default_scale, true, global.src_statis,"shoulder")
knowledge_base_add(spr_glow_leg, global.glow_name, 4, global.default_scale, true, global.src_statis,"leg")
//knowledge_base_add(spr_glow_shin, global.glow_name, 4, global.default_scale, true, global.src_statis,"shin")
knowledge_base_add(spr_glow_foot, global.glow_name, 4, global.default_scale, true, global.src_statis,"foot")
knowledge_base_add(spr_glow_torso, global.glow_name, 4, global.default_scale, true, global.src_statis,"torso")
knowledge_base_add(spr_glow_helmet, global.glow_name, 4, global.default_scale, true, global.src_statis,"helmet")
global.armor_sets[14,1] = spr_glow_foot

//gold
global.gold_name = "Gold Plated"
global.gold_rarity = 2
global.armor_sets[15,0] = spr_gold_helmet
knowledge_base_add(spr_gold_forearm, global.gold_name, global.gold_rarity, global.default_scale, true, global.src_challenge,"forearm")
knowledge_base_add(spr_gold_shoulder, global.gold_name, global.gold_rarity, global.default_scale, true, global.src_challenge,"shoulder")
knowledge_base_add(spr_gold_leg, global.gold_name, global.gold_rarity, global.default_scale, true, global.src_challenge,"leg")
knowledge_base_add(spr_gold_shin, global.gold_name, global.gold_rarity, global.default_scale, true, global.src_challenge,"shin")
knowledge_base_add(spr_gold_foot, global.gold_name, global.gold_rarity, global.default_scale, true, global.src_challenge,"foot")
knowledge_base_add(spr_gold_torso, global.gold_name, global.gold_rarity, global.default_scale, true, global.src_challenge,"torso")
knowledge_base_add(spr_gold_helmet, global.gold_name, global.gold_rarity, global.default_scale, true, global.src_challenge,"helmet")
global.armor_sets[15,1] = spr_gold_foot

//heavy
global.heavy_name = "Green Mutha Ucka"
global.heavy_rarity = 3
global.heavy_src = global.src_challenge
global.armor_sets[16,0] = spr_heavy_helmet
knowledge_base_add(spr_heavy_forearm, global.heavy_name, global.heavy_rarity, global.default_scale, true, global.heavy_src,"forearm")
knowledge_base_add(spr_heavy_shoulder, global.heavy_name, global.heavy_rarity, global.default_scale, true, global.heavy_src,"shoulder")
knowledge_base_add(spr_heavy_leg, global.heavy_name, global.heavy_rarity, global.default_scale, true, global.heavy_src,"leg")
knowledge_base_add(spr_heavy_shin, global.heavy_name, global.heavy_rarity, global.default_scale, true, global.heavy_src,"shin")
knowledge_base_add(spr_heavy_foot, global.heavy_name, global.heavy_rarity, global.default_scale, true, global.heavy_src,"foot")
knowledge_base_add(spr_heavy_torso, global.heavy_name, global.heavy_rarity, global.default_scale, true, global.heavy_src,"torso")
knowledge_base_add(spr_heavy_helmet, global.heavy_name, global.heavy_rarity, global.default_scale, true, global.heavy_src,"helmet")
global.armor_sets[16,1] = spr_heavy_foot

//hiker
global.hiker_name = "Bandit"
global.hiker_rarity = 1
global.hiker_src = global.src_lotto
global.armor_sets[17,0] = spr_hiker_helmet
knowledge_base_add(spr_hiker_forearm, global.hiker_name, global.hiker_rarity, global.default_scale, true, global.hiker_src,"forearm")
knowledge_base_add(spr_hiker_shoulder, global.hiker_name, global.hiker_rarity, global.default_scale, true, global.hiker_src,"shoulder")
knowledge_base_add(spr_hiker_leg, global.hiker_name, global.hiker_rarity, global.default_scale, true, global.hiker_src,"leg")
knowledge_base_add(spr_hiker_shin, global.hiker_name, global.hiker_rarity, global.default_scale, true, global.hiker_src,"shin")
knowledge_base_add(spr_hiker_foot, global.hiker_name, global.hiker_rarity, global.default_scale, true, global.hiker_src,"foot")
knowledge_base_add(spr_hiker_torso, global.hiker_name, global.hiker_rarity, global.default_scale, true, global.hiker_src,"torso")
knowledge_base_add(spr_hiker_helmet, global.hiker_name, global.hiker_rarity, global.default_scale, true, global.hiker_src,"helmet")
global.armor_sets[17,1] = spr_hiker_foot

//leather
global.leather_name = "Leather"
global.leather_rarity = 1
global.leather_src = global.src_lotto
global.armor_sets[18,0] = spr_leather_helmet
knowledge_base_add(spr_leather_forearm, global.leather_name, global.leather_rarity, global.default_scale, true, global.leather_src,"forearm")
knowledge_base_add(spr_leather_shoulder, global.leather_name, global.leather_rarity, global.default_scale, true, global.leather_src,"shoulder")
knowledge_base_add(spr_leather_leg, global.leather_name, global.leather_rarity, global.default_scale, true, global.leather_src,"leg")
knowledge_base_add(spr_leather_shin, global.leather_name, global.leather_rarity, global.default_scale, true, global.leather_src,"shin")
knowledge_base_add(spr_leather_foot, global.leather_name, global.leather_rarity, global.default_scale, true, global.leather_src,"foot")
knowledge_base_add(spr_leather_torso, global.leather_name, global.leather_rarity, global.default_scale, true, global.leather_src,"torso")
knowledge_base_add(spr_leather_helmet, global.leather_name, global.leather_rarity, global.default_scale, true, global.leather_src,"helmet")
global.armor_sets[18,1] = spr_leather_foot

//med
global.med_name = "Blue Mutha Ucka"
global.med_rarity = 3
global.med_src = global.src_challenge
global.armor_sets[19,0] = spr_med_helmet
knowledge_base_add(spr_med_forearm, global.med_name, global.med_rarity, global.default_scale, true, global.med_src,"forearm")
knowledge_base_add(spr_med_shoulder, global.med_name, global.med_rarity, global.default_scale, true, global.med_src,"shoulder")
knowledge_base_add(spr_med_leg, global.med_name, global.med_rarity, global.default_scale, true, global.med_src,"leg")
knowledge_base_add(spr_med_shin, global.med_name, global.med_rarity, global.default_scale, true, global.med_src,"shin")
knowledge_base_add(spr_med_foot, global.med_name, global.med_rarity, global.default_scale, true, global.med_src,"foot")
knowledge_base_add(spr_med_torso, global.med_name, global.med_rarity, global.default_scale, true, global.med_src,"torso")
knowledge_base_add(spr_med_helmet, global.med_name, global.med_rarity, global.default_scale, true, global.med_src,"helmet")
global.armor_sets[19,1] = spr_med_foot

//husky
global.husky_name = "Husky"
global.husky_rarity = 2
global.husky_src = global.src_lotto
global.armor_sets[20,0] = spr_husky_helmet
knowledge_base_add(spr_husky_forearm, global.husky_name, global.husky_rarity, global.default_scale, true, global.husky_src,"forearm")
knowledge_base_add(spr_husky_shoulder, global.husky_name, global.husky_rarity, global.default_scale, true, global.husky_src,"shoulder")
knowledge_base_add(spr_husky_leg, global.husky_name, global.husky_rarity, global.default_scale, true, global.husky_src,"leg")
knowledge_base_add(spr_husky_shin, global.husky_name, global.husky_rarity, global.default_scale, true, global.husky_src,"shin")
knowledge_base_add(spr_husky_foot, global.husky_name, global.husky_rarity, global.default_scale, true, global.husky_src,"foot")
knowledge_base_add(spr_husky_torso, global.husky_name, global.husky_rarity, global.default_scale, true, global.husky_src,"torso")
knowledge_base_add(spr_husky_helmet, global.husky_name, global.husky_rarity, global.default_scale, true, global.husky_src,"helmet")
global.armor_sets[20,1] = spr_husky_foot

//muscle
global.muscle_name = "Swol"
global.muscle_rarity = 3
global.muscle_src = global.src_challenge
global.armor_sets[21,0] = spr_muscle_helmet
knowledge_base_add(spr_muscle_forearm, global.muscle_name, global.muscle_rarity, global.default_scale, true, global.muscle_src,"forearm")
knowledge_base_add(spr_muscle_shoulder, global.muscle_name, global.muscle_rarity, global.default_scale, true, global.muscle_src,"shoulder")
knowledge_base_add(spr_muscle_leg, global.muscle_name, global.muscle_rarity, global.default_scale, true, global.muscle_src,"leg")
knowledge_base_add(spr_muscle_shin, global.muscle_name, global.muscle_rarity, global.default_scale, true, global.muscle_src,"shin")
knowledge_base_add(spr_muscle_foot, global.muscle_name, global.muscle_rarity, global.default_scale, true, global.muscle_src,"foot")
knowledge_base_add(spr_muscle_torso, global.muscle_name, global.muscle_rarity, global.default_scale, true, global.muscle_src,"torso")
knowledge_base_add(spr_muscle_helmet, global.muscle_name, global.muscle_rarity, global.default_scale, true, global.muscle_src,"helmet")
global.armor_sets[21,1] = spr_muscle_foot

//trace
global.trace_name = "Trace"
global.trace_rarity = 2
global.trace_src = global.src_challenge
global.armor_sets[22,0] = spr_trace_helmet
knowledge_base_add(spr_trace_forearm, global.trace_name, global.trace_rarity, global.default_scale, true, global.trace_src,"forearm")
knowledge_base_add(spr_trace_shoulder, global.trace_name, global.trace_rarity, global.default_scale, true, global.trace_src,"shoulder")
knowledge_base_add(spr_trace_leg, global.trace_name, global.trace_rarity, global.default_scale, true, global.trace_src,"leg")
knowledge_base_add(spr_trace_shin, global.trace_name, global.trace_rarity, global.default_scale, true, global.trace_src,"shin")
knowledge_base_add(spr_trace_foot, global.trace_name, global.trace_rarity, global.default_scale, true, global.trace_src,"foot")
knowledge_base_add(spr_trace_torso, global.trace_name, global.trace_rarity, global.default_scale, true, global.trace_src,"torso")
knowledge_base_add(spr_trace_helmet, global.trace_name, global.trace_rarity, global.default_scale, true, global.trace_src,"helmet")
global.armor_sets[22,1] = spr_trace_foot

//samurai
global.samurai_name = "Samurai"
global.samurai_rarity = 4
global.samurai_src = global.src_challenge
global.armor_sets[23,0] = spr_samurai_helmet
knowledge_base_add(spr_samurai_forearm, global.samurai_name, global.samurai_rarity, global.default_scale, true, global.samurai_src,"forearm")
knowledge_base_add(spr_samurai_shoulder, global.samurai_name, global.samurai_rarity, global.default_scale, true, global.samurai_src,"shoulder")
knowledge_base_add(spr_samurai_leg, global.samurai_name, global.samurai_rarity, global.default_scale, true, global.samurai_src,"leg")
knowledge_base_add(spr_samurai_shin, global.samurai_name, global.samurai_rarity, global.default_scale, true, global.samurai_src,"shin")
knowledge_base_add(spr_samurai_foot, global.samurai_name, global.samurai_rarity, global.default_scale, true, global.samurai_src,"foot")
knowledge_base_add(spr_samurai_torso, global.samurai_name, global.samurai_rarity, global.default_scale, true, global.samurai_src,"torso")
knowledge_base_add(spr_samurai_helmet, global.samurai_name, global.samurai_rarity, global.default_scale, true, global.samurai_src,"helmet")
global.armor_sets[23,1] = spr_samurai_foot

//ninja
global.ninja_name = "Ninja"
global.ninja_rarity = 3
global.ninja_src = global.src_challenge
global.armor_sets[24,0] = spr_ninja_helmet
knowledge_base_add(spr_ninja_forearm, global.ninja_name, global.ninja_rarity, global.default_scale, true, global.ninja_src,"forearm")
knowledge_base_add(spr_ninja_shoulder, global.ninja_name, global.ninja_rarity, global.default_scale, true, global.ninja_src,"shoulder")
knowledge_base_add(spr_ninja_leg, global.ninja_name, global.ninja_rarity, global.default_scale, true, global.ninja_src,"leg")
knowledge_base_add(spr_ninja_shin, global.ninja_name, global.ninja_rarity, global.default_scale, true, global.ninja_src,"shin")
knowledge_base_add(spr_ninja_foot, global.ninja_name, global.ninja_rarity, global.default_scale, true, global.ninja_src,"foot")
knowledge_base_add(spr_ninja_torso, global.ninja_name, global.ninja_rarity, global.default_scale, true, global.ninja_src,"torso")
knowledge_base_add(spr_ninja_helmet, global.ninja_name, global.ninja_rarity, global.default_scale, true, global.ninja_src,"helmet")
global.armor_sets[24,1] = spr_ninja_foot

//underwear
global.underwear_name = "Underwear"
global.underwear_rarity = 0
global.underwear_src = global.src_challenge
global.armor_sets[25,0] = spr_underwear_helmet
knowledge_base_add(spr_underwear_forearm, global.underwear_name, global.underwear_rarity, global.default_scale, true, global.underwear_src,"forearm")
knowledge_base_add(spr_underwear_shoulder, global.underwear_name, global.underwear_rarity, global.default_scale, true, global.underwear_src,"shoulder")
knowledge_base_add(spr_underwear_leg, global.underwear_name, global.underwear_rarity, global.default_scale, true, global.underwear_src,"leg")
knowledge_base_add(spr_underwear_shin, global.underwear_name, global.underwear_rarity, global.default_scale, true, global.underwear_src,"shin")
knowledge_base_add(spr_underwear_foot, global.underwear_name, global.underwear_rarity, global.default_scale, true, global.underwear_src,"foot")
knowledge_base_add(spr_underwear_torso, global.underwear_name, global.underwear_rarity, global.default_scale, true, global.underwear_src,"torso")
knowledge_base_add(spr_underwear_helmet, global.underwear_name, global.underwear_rarity, global.default_scale, true, global.underwear_src,"helmet")
global.armor_sets[25,1] = spr_underwear_foot

//orange
global.orange_name = "Tiger"
global.orange_rarity = 3
global.orange_src = global.src_challenge
global.armor_sets[26,0] = spr_orange_helmet
knowledge_base_add(spr_orange_forearm, global.orange_name, global.orange_rarity, global.default_scale, true, global.orange_src,"forearm")
knowledge_base_add(spr_orange_shoulder, global.orange_name, global.orange_rarity, global.default_scale, true, global.orange_src,"shoulder")
knowledge_base_add(spr_orange_leg, global.orange_name, global.orange_rarity, global.default_scale, true, global.orange_src,"leg")
knowledge_base_add(spr_orange_shin, global.orange_name, global.orange_rarity, global.default_scale, true, global.orange_src,"shin")
knowledge_base_add(spr_orange_foot, global.orange_name, global.orange_rarity, global.default_scale, true, global.orange_src,"foot")
knowledge_base_add(spr_orange_torso, global.orange_name, global.orange_rarity, global.default_scale, true, global.orange_src,"torso")
knowledge_base_add(spr_orange_helmet, global.orange_name, global.orange_rarity, global.default_scale, true, global.orange_src,"helmet")
global.armor_sets[26,1] = spr_orange_foot
