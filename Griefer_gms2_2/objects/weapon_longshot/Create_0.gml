action_inherited();
///Weapon Constants

//bot weapon selection
varWrite("lethality",20)
varWrite("range_rating",64*20)
varWrite("range_trump",true)
varWrite("range_trump_distance",64*15)
varWrite("range_trump_extra_lethality",10)

//graphics
myCursor = cursor_long
varWrite("sprite",spr_longshot)
varWrite("name",global.longshot)
varWrite("icon",spr_longshot)
varWrite("bullet_icon",icon_bullet_long)
varWrite("pose",global.longshot_pose)
varWrite("muzzle_offset",132)
varWrite("scale",global.longshot_scale)
varWrite("flash",flash_shotgun)

//engined
varWrite("sound_reload",snd_reload_longshot)
varWrite("is_nade",false)
varWrite("is_secondary",false)

//specs
varWrite("clip_cap",1)
varWrite("clip",varRead("clip_cap"))
varWrite("starting_ammo",9*varRead("clip_cap"))
varWrite("max_ammo",26*varRead("clip_cap"))
varWrite("ammo",varRead("starting_ammo"))
varWrite("reload_time",ceil(0.75*30))

//shooting mechanics
varWrite("view_scale",1.5)
varWrite("kick",20)
varWrite("bullet",bullet_long)
varWrite("bullet_speed",90)
varWrite("control_type","left_press")
varWrite("cant_shoot_max",3)
varWrite("spread_count",1)
varWrite("spread_swath",0)
varWrite("recoil",15)
//varWrite("handling",1.25)
varWrite("view_shake_duration","short") //short, medium, long
varWrite("view_shake",8)

