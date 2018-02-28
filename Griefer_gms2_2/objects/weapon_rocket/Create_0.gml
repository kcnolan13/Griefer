action_inherited();
///Weapon Constants

//bot weapon selection
varWrite("lethality",30)
varWrite("range_rating",64*8)
varWrite("range_trump",true)
varWrite("range_trump_distance",64*4)
varWrite("range_trump_extra_lethality",10)

//graphics
myCursor = cursor_rocket
varWrite("sprite",spr_rocket)
varWrite("name",global.rocket)
varWrite("icon",spr_rocket)
varWrite("bullet_icon",icon_bullet_thicker)
varWrite("pose",global.rocket_pose)
varWrite("muzzle_offset",140)
varWrite("scale",global.rocket_scale)
varWrite("flash",flash_rocket)

//engined
varWrite("sound_reload",snd_reload_rocket)
varWrite("is_nade",false)
varWrite("is_secondary",false)

//specs
varWrite("clip_cap",1)
varWrite("clip",varRead("clip_cap"))
varWrite("starting_ammo",3*varRead("clip_cap"))
varWrite("max_ammo",8*varRead("clip_cap"))
varWrite("ammo",varRead("starting_ammo"))
varWrite("reload_time",ceil(2*30))

//shooting mechanics
varWrite("view_scale",1.2)
varWrite("kick",20)
varWrite("bullet",bullet_rocket)
varWrite("bullet_speed",4)
varWrite("control_type","left_hold")
varWrite("cant_shoot_max",10)
varWrite("spread_count",1)
varWrite("spread_swath",0)
varWrite("recoil",10)
//varWrite("handling",1.25)
varWrite("view_shake_duration","medium") //short, medium, long
varWrite("view_shake",10)

