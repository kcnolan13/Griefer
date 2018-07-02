action_inherited();
///Weapon Constants

//bot weapon selection
varWrite("lethality",25)
varWrite("range_rating",64*8)
varWrite("range_trump",true)
varWrite("range_trump_distance",64*4)
varWrite("range_trump_extra_lethality",10)

//graphics
myCursor = cursor_boom
varWrite("sprite",spr_boom)
varWrite("name",global.boom)
varWrite("icon",spr_boom)
varWrite("bullet_icon",icon_bullet_thicker)
varWrite("pose",global.boom_pose)
varWrite("muzzle_offset",120)
varWrite("scale",global.boom_scale)
varWrite("flash",flash_boom)

//engined
varWrite("sound_reload",snd_reload_1_5)
varWrite("is_nade",false)
varWrite("is_secondary",false)

//specs
varWrite("clip_cap",3)
varWrite("clip",varRead("clip_cap"))
varWrite("starting_ammo",3*varRead("clip_cap"))
varWrite("max_ammo",5*varRead("clip_cap"))
varWrite("ammo",varRead("starting_ammo"))
varWrite("reload_time",ceil(1.5*30))

//shooting mechanics
varWrite("view_scale",1.1)
varWrite("kick",20)
varWrite("bullet",bullet_boom)
varWrite("bullet_speed",30)
varWrite("control_type","left_hold")
varWrite("cant_shoot_max",10)
varWrite("spread_count",1)
varWrite("spread_swath",0)
varWrite("recoil",10)
//varWrite("handling",1.25)
varWrite("view_shake_duration","medium") //short, medium, long
varWrite("view_shake",5)

