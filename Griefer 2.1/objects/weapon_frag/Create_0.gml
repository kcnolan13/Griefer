action_inherited();
///Weapon Constants

//bot weapon selection
varWrite("lethality",5)
varWrite("range_rating",64*6.5)
varWrite("range_trump",false)
varWrite("range_trump_distance",64*8)

//graphics
myCursor = cursor_frag
varWrite("sprite",spr_frag)
varWrite("name",global.frag)
varWrite("icon",spr_frag)
varWrite("bullet_icon",spr_none)
varWrite("pose",global.nade_pose)
varWrite("muzzle_offset",70)
varWrite("scale",global.nade_scale)
varWrite("flash",flash_none)

varWrite("traj_gravity",2)
varWrite("traj_rigidity",3)
varWrite("traj_color",c_white)    //trajectory main color
varWrite("traj_width",3)          //width of main segments
varWrite("traj_resolution",1)    //frames per segment
varWrite("traj_length",64*12)      //trajectory length
varWrite("traj_alpha1",1)         //starting alpha
varWrite("traj_alpha2",1)         //alpha in middle
varWrite("traj_alpha3",0)         //alpha at end
varWrite("traj_highlight",spr_none) //trajectory highlight sprite
//varWrite("traj_highlight_color",c_white)
varWrite("traj_highlight_interval",64*1) //distance between highlights

//engine
varWrite("is_nade",true)
varWrite("is_secondary",false)

//specs
varWrite("clip_cap",1)
varWrite("clip",varRead("clip_cap"))
varWrite("starting_ammo",0*varRead("clip_cap"))
varWrite("max_ammo",5*varRead("clip_cap"))
varWrite("ammo",varRead("starting_ammo"))
varWrite("reload_time",2)

varWrite("charge_delay",30/2)
varWrite("charge_weight",2)
varWrite("discharge_delay_max",5)

//shooting mechanics
varWrite("kick",0)
varWrite("bullet",bullet_frag)
varWrite("bullet_speed",62)
varWrite("control_type","left_charge")
varWrite("cant_shoot_max",3)
varWrite("spread_count",1)
varWrite("spread_swath",0)
varWrite("recoil",8)
//varWrite("handling",1.25)
varWrite("view_shake_duration","short") //short, medium, long
varWrite("view_shake",0)


