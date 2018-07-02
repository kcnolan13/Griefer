/// @description DO LOTS OF STUFF

//30 = 60 --> now do this after objects that have init based on room speed have a chance to go
alarm[7] = 2
cross_referenced_options = false

global.xoff = 0

sounded_lotto_slot[0] = false
sounded_lotto_slot[1] = false
sounded_lotto_slot[2] = false

for (var i=0; i<NUM_LIMBS; i++)
{
    grid_lalphs[i] = 0
}

init_physics()

if load_room_start
{
    load_room_start = false
    ID = popup_loading(WVIEW/2,HVIEW/2)
    ID.load_closable = false
}

if room = rm_menu
{
    bot_match = false
    if match_collapsed
    {
        popup_okay(WVIEW/2,HVIEW/2,pluralize("Rage Quitter",collapsed_pluralize), string(collapsed_pname)+" "+pluralize("has",collapsed_pluralize)+" Rage Quit. You have been awarded the win, and "+string(collapsed_pname)+" "+pluralize("has",collapsed_pluralize)+" been penalized.",scr_none)
        match_collapsed = false
        collapsed_numplayers = 0
        collapsed_pluralize = 0
        collapsed_pname = ""
        varWrite("everyone_quit",false)
    }
}
    
__view_set( e__VW.HPort, 0, 768 )
__view_set( e__VW.WPort, 0, 1365 )
__view_set( e__VW.HView, 0, 768 )
__view_set( e__VW.WView, 0, 1365 )

if in_match()
{
    //zero out the global load counter -- start fresh!!
    global.load_count = 0
    default_winner = ""
    match_collapsed = false
    collapsed_numplayers = 0
    collapsed_pluralize = 0
    collapsed_pname = ""
    everyone_quit = false
    varWrite("everyone_quit",false)
    part_controller = instance_create(x,y,particle_controller)
    map_previous = global.map_names[room]
    disable_scores = false
    respawn_flag = FL_NORMAL
}

room_counter =0

win_popup_scale = 0.5
win_popup_scale_max = 1.5
win_popup_width = 72*3.25
win_popup_height = 72*3
win_popup_lerp_real = 0.035//25
win_color = c_white
win_popup_alpha = 0
win_popup_alpha_max = 0.75

varWrite("match_started",false)
varWrite("gearsteal_computed",false)

if room = rm_lobby
{
    time_after_readies = -1
    varWrite("next_map", -54)
    varWrite("next_map1",-54)
    varWrite("next_map2",-54)
    varWrite("next_map3",-54)
    
    player_limit = get_player_limit(varRead("game_mode"))
    if bot_match and not came_from_match
    {
        instantiate_all_bots(get_player_limit(varRead("game_mode"))-1)
    }
    
    alarm[3] = 30*5
    //alarm[3] = floor(random_range(30*4,30*8))
    saving_armor = false
    if varRead("lobby_wait_time") < 30*20
        varWrite("lobby_wait_time",lobby_wait_time)
    lock_armory = false
    menu_mode = "lobby"
    
    if came_from_match
    {
        menu_mode = "lottery_steal"
        mode_counter = lottery_time+steal_time
        hide_avatars = false //true
    }
    
    av_padding = room_width/instance_number(avatar)
    for (var i=0; i<instance_number(avatar); i++)
    {
        ID = instance_find(avatar,i)
        
        if not hide_avatars
            ID.y = 0
        else
            ID.y = -64*10
            
        ID.x = av_padding*(objVarRead(ID,"pNum")+0.5)
    }
}

if room = rm_menu
{
    varWrite("stole_gear",false)
    varWrite("lost_gear",false)
    varWrite("lost_gear_source","")
    varWrite("stole_gear_source","")
    varWrite("stole_gear_sprite",false)
    varWrite("lost_gear_sprite",false)
    varWrite("transacted_player","")
    bpart_transacted = noone
    came_from_match = false
    bpart_lotto[0] = noone
    bpart_lotto[1] = noone
    bpart_lotto[2] = noone
    saving_armor = false
    lock_armory = false
    varWrite("uniqueId","-1")
    menu_mode = "play"
    varWrite("game_mode","no_mode")

    with bn_play
        event_perform(ev_mouse,ev_left_press)

    if debug_autoplay 
    {
        debug_autoplay = false
        if varRead("pName") = "marcel" or varRead("pName") = "kyle"
            some_mode = "ffa"
        else
            some_mode = "tdm"
        start_matchmaking(some_mode)
    }
}

if in_match()
{

    //create sortable player grids. to be used like --->  kills, avatar_obj
    if ds_exists(ds_type_grid,team_all)
        ds_grid_destroy(team_all)
    
    if ds_exists(ds_type_grid,team0)
        ds_grid_destroy(team0)
    
    if ds_exists(ds_type_grid,team1)
        ds_grid_destroy(team1)
        
    team_all = ds_grid_create(3,instance_number(avatar))
    team1 = ds_grid_create(3,floor(instance_number(avatar)/2))
    team0 = ds_grid_create(3,ceil(instance_number(avatar)/2))
    
    //give 3 seconds before populating team datastructures
    alarm[6] = 3*30
    

    varWrite("match_flag",FL_NEUTRAL)
    computed_winloss = false
    varWrite("winning_pName","")
    came_from_match = true
    objVarWrite(net_manager,"lost_gear",false)
    objVarWrite(net_manager,"stole_gear",false)

    lotto_ready = false
    
    if ds_exists(avatar_winners,ds_type_list)
        ds_list_destroy(avatar_winners)
        
    if ds_exists(avatar_losers,ds_type_list)
        ds_list_destroy(avatar_losers)
        
    avatar_winners = ds_list_create()
    avatar_losers = ds_list_create() 
    
    starting_match = starting_match_delay
    
    //randomize the seed used to calculate random numbers
    randomize()
    
    //stuff that should be reset when you enter a match
    match_countdown = -99
    win_countdown = -99
    gear_lost = false
    varWrite("end_match_coming",false)
    
    num_players = 1
    team = -1
    team_kills = 0
}


if room = rm_lobby and match_collapsed
{
    abort_match()
}

///compute lowest pnum
if room != rm_login
    compute_lowest_pnum()

///login screen ----> create login UI elements
if room = rm_login
{
    room_speed = 60
    
    sendMessageReal("get_top_gravatars",1)
    popup_loading(WVIEW/2,HVIEW/2)
    
    var login_col_width = WVIEW/5
    var login_col_bdelay = 30*7
    var bn_yoff = HVIEW*1/3
    var bn_ysep = 64*1
    var bn_height = 64*0.8
    var bn_width = login_col_width*4/5
    var translation_lerp = 0.08
    {
        //LEFT HAND COLUMN
        login_col = instance_create(-1*login_col_width,0,modal_window)
        login_col.width = login_col_width
        login_col.height = HVIEW
        login_col.text_halign = fa_center
        login_col.text_valign = fa_top
        login_col.text_yoff = 64*1.5
        login_col.font = fnt_login
        login_col.header_height = 0//bn_height*2
        login_col.birth_delay = login_col_bdelay
        login_col.color = web_hsv(220,0,20)
        //login_col.header_color = web_hsv(220,50,20)
        //login_col.header_text_color = c_white
        login_col.text_color = c_white
        login_col.translation_xtarget = login_col_width
        login_col.translation_lerp = translation_lerp
        login_col.depth = 0
        login_col.highlightable = false
        login_col.text = "Log In"
        login_col.bind_global_xoff_to_translation_x = true
        login_col.alpha_max = 1
        login_col.wait_while_loading = true
        
        //gradient?
        login_col.draw_gradient = true
        login_col.grad1 = web_hsv(220,0,55)
        login_col.grad2 = login_col.grad1
        login_col.grad3 = web_hsv(220,0,10)
        login_col.grad4 = login_col.grad3
        
        //username input
        uname = instance_create(-1*login_col_width/2,bn_yoff+(bn_height+bn_ysep)*0,bn_input_field)
        uname.width = bn_width
        uname.height = bn_height
        uname.max_length = 20
        uname.birth_delay = login_col_bdelay
        uname.sequence = 1
        uname.randomize_username = true
        uname.is_username = true
        uname.text_default = "Player Name"
        uname.text = uname.text_default
        uname.translation_xtarget = login_col_width
        uname.translation_lerp = translation_lerp
        uname.depth = -10
        uname.color = web_hsv(220,0,55)
        uname.active_color = web_hsv(235,0,85)
        uname.text_color_input = c_black
        uname.text_color_default = c_white
        uname.wait_while_loading = true
        with uname modal_aligns()
        
        //password input
        pword = instance_create(-1*login_col_width/2,bn_yoff+(bn_height+bn_ysep)*1,bn_input_field)
        pword.width = bn_width
        pword.height = bn_height
        pword.max_length = 20
        pword.birth_delay = login_col_bdelay
        pword.sequence = 2
        pword.is_password = true
        pword.text_default = "Password"
        pword.text = pword.text_default
        pword.translation_xtarget = login_col_width
        pword.translation_lerp = translation_lerp
        pword.min_length = 6
        pword.depth = -10
        pword.auto_start = false
        pword.color = uname.color
        pword.active_color = uname.active_color
        pword.text_color_input = uname.text_color_input
        pword.text_color_default = uname.text_color_default
        pword.wait_while_loading = true
        with pword modal_aligns()
        
        //play button
        play = instance_create(-1*login_col_width/2,bn_yoff+(bn_height+bn_ysep)*2,bn_typical)
        play.width = bn_width
        play.height = bn_height
        play.max_length = 20
        play.birth_delay = login_col_bdelay
        play.translation_xtarget = login_col_width
        play.translation_lerp = translation_lerp
        play.submit_action = scr_submit_play
        play.can_press_enter = true
        play.can_press_enter_always = true
        play.depth = -10
        play.color = web_hsv(220,80,5)
        play.alpha_max = 0.925
        play.wait_while_loading = true
        with play modal_aligns()
        
        //randomize username button
        rand = instance_create(-1*login_col_width/2,room_height-bn_height/2-(login_col.width-bn_width)/2,bn_typical)
        rand.text = "Random Username"
        rand.width = bn_width
        rand.height = bn_height
        rand.max_length = 20
        rand.birth_delay = login_col_bdelay
        rand.translation_xtarget = login_col_width
        rand.translation_lerp = translation_lerp
        rand.submit_action = scr_randomize_username
        rand.can_press_enter = true
        rand.can_press_enter_always = true
        rand.depth = -10
        rand.color = web_hsv(220,0,9)
        rand.alpha_max = 0.925
        rand.wait_while_loading = true
        with rand modal_aligns()
    }
}

///random user creation
if room = rm_login
    alarm[9] = 200
else
    alarm[9] = room_speed

