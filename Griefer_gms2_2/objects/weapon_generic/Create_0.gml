/// @description DEFINITIONS
depth = -12
netvars = ds_map_create()

myFlash = noone
noflash_counter = 0
bounces = 0

//dummy vars
counter = 0
exclude_bots = false

was_active = false
reached_hitscan = false
max_charge_counter = 0
mi_jugador = NO_HANDLE
dat_jugador = NO_HANDLE

destroyed = false

varWrite("sound_reload",snd_reload0)

//bot weapon selection
varWrite("lethality",0)
varWrite("range_rating",64*8)
varWrite("range_trump",false)
varWrite("range_trump_distance",64*8)
varWrite("range_trump_extra_lethality",0)

//graphics
myCursor = cursor_pistol
varWrite("visible",false)
varWrite("name","Snub Pistol")
varWrite("sprite",spr_pistol)           //in-game weapon image
varWrite("icon",spr_pistol)             //GUI weapon image
varWrite("bullet_icon",icon_bullet)     //GUI shell icon
varWrite("muzzle_offset",70)            //how far away to spawn bullets
varWrite("pose","pistol")               //arm pose to use
varWrite("scale",1)                     //prescale weapon size
varWrite("flash",flash_pistol)          //muzzle flash object

//trajectories
varWrite("draw_trajectory",false)
varWrite("traj_gravity",2)        //projectile gravity
varWrite("traj_rigidity",3)       //projectile rigidity
varWrite("traj_color",c_white)    //trajectory main color
varWrite("traj_width",2)          //width of main segments
varWrite("traj_resolution",16)    //pixels per line segment
varWrite("traj_length",64*8)      //trajectory length
varWrite("traj_alpha1",1)         //starting alpha
varWrite("traj_alpha2",1)         //alpha in middle
varWrite("traj_alpha3",0)         //alpha at end
varWrite("traj_highlight",spr_tossable_generic) //trajectory highlight sprite
//varWrite("traj_highlight_color",c_white)
varWrite("traj_highlight_interval",64*1) //distance between highlights
varWrite("traj_flag",FL_BOUNCE)

//specs
varWrite("clip_cap",12)                 //clip capacity
varWrite("clip",varRead("clip_cap"))
varWrite("starting_ammo",3*varRead("clip_cap"))
varWrite("max_ammo",5*varRead("clip_cap"))
varWrite("ammo",varRead("starting_ammo"))
varWrite("clip_decrement",1)            //how much to subtract with each trigger pull
varWrite("reload_time",1*30)
varWrite("charge_delay",30)     //length of time to full charge
varWrite("charge_weight",2)             //charge % = ((charge_delay-charge_counter)+charge_delay*charge_weight)/(1+charge_weight)
varWrite("charge_counter",-1)
varWrite("charge",0)                    //charge % --> 0 to 1
varWrite("charge_offset",0.25)          //initial charge so it doesnt drop at your feet --> 0 to 1
varWrite("discharge_delay_max",4)       //time after mouse release when nade is thrown
varWrite("discharge_delay",-1)
varWrite("quicktoss_charge",0.75)       //charge % for quicktoss
varWrite("quicktoss_discharge_delay_max",4) //frames before quicktoss actually occurs

//shooting mechanics
varWrite("view_scale",1)               //view scale multiplier
varWrite("kick",10)                     //visual arm recoil
varWrite("bullet",bullet_pistol)        //bullet object
varWrite("bullet_speed",50)             
varWrite("cant_shoot_max",3)            //delay after shooting
varWrite("cant_shoot_max_original",3)
varWrite("spread_count",1)              //num bullets to fire         
varWrite("spread_swath",0)              //angular spreadshot swath
varWrite("spread_spawn_translation",16) //bullet x-y spawn range around muzzle
varWrite("inaccuracy",0)                //random angle added to bullets
varWrite("recoil",5)                    //increments inaccuracy with each shot
varWrite("handling",1.25)               //how fast inaccuracy goes down
varWrite("view_shake_duration","short") //short, medium, long
varWrite("view_shake",5)

//engine
time_since_shot = 0
varWrite("cant_shoot",false)
varWrite("active",false)                //true when in-use by local player
varWrite("is_nade",false)
varWrite("is_secondary",false)
varWrite("my_player",MY_PLAYER_NULL)                //uniqueId of bonded player
varWrite("control_type","left_press")   //fire button left_press, left_hold, or left_charge
varWrite("can_disappear",true)          //disappear from the battlefield after a while
varWrite("disappear_counter",-1)         
varWrite("disappear_delay",60*10)
varWrite("reload_counter",-1)
varWrite("reload_incremental",false)
varWrite("reload_empty_delay",30/2)
varWrite("reload_empty_counter",-1)
varWrite("quicktoss_backcycles",0)
varWrite("quicktoss_time_between",4)
varWrite("quicktoss_timer",0)
varWrite("clip_previous",0)
varWrite("ammo_previous",0)

//dummy var
varWrite("flash_hitscan",flash_hitscan_simple_long)

varWrite("spawner",-1)
varWrite("been_picked_up",false)

sprite_index = spr_weapon_generic
initialize_physics()

