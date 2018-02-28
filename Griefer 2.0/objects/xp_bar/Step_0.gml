/// @description recompute xp vars


if room = rm_lobby
{
    if net_manager.menu_mode = "lottery_steal" and xp_2earn < 1
        xp_done_counter += real_speed(1)
    else
        xp_done_counter = 0
}

xp = objVarRead(net_manager,"xp")

if not xp_replay
{
    rank = objVarRead(net_manager,"rank")
}

if rank < 0
    rank = 0
    
if xp < 0
    xp = 0
    
recompute_xp_vars()

//printf("ERROR: xp = "+string(xp)+", xp_next = "+string(xp_next)+", xp_prev = "+string(xp_prev))


///earn xp

if room = rm_menu and alpha < 1
    earn_pauser = 5

if xp_2earn > 0
{
    if not earn_pauser
    {
        if rank = objVarRead(net_manager,"rank") and (xp_next - xp) > -100
            xp_2earn = lerp_real(xp_2earn,0,earn_lerp_real)
        else
        {
            //printf("::: xp_2earn = "+string(xp_2earn))
            if rank+1 < getLength(global.rank_names)
                xp_2earn -= (global.rank_xp[rank+1] - global.rank_xp[rank])/30
            else
                xp_2earn -= 200
                
            if xp_2earn < 0
                xp_2earn = 0
        }
    }
    else
        earn_pauser --
    
    if xp_2earn < 1 and rank = objVarRead(net_manager,"rank")
    {
        xp_2earn = 0
        xp_replay = false
    }
    
    if not alpha_override   
        alpha = 1+dec*fade_delay
}
else if alpha > 0 and not alpha_override
{
    alpha -= dec
    if alpha < 0.05
        alpha = 0
}

///get promoted
//printf("ERROR: xp_2earn = "+string(xp_2earn)+", xp = "+string(xp)+", xp_next = "+string(xp_next)+", av?  "+string(is_my_avatar(net_manager.my_doll)))
if xp_needed <= 0 and not earn_pauser and is_my_avatar(net_manager.my_doll)
{   
    rank ++
    recompute_xp_vars()
    
    //if not xp_replay
    xp_2earn = xp-xp_prev
    
    if in_match()
        earn_pauser = 30*3
    else
    {
        earn_pauser = 30*3
        if room = rm_lobby
        {
            with bn_postmatch_done cant_fade = true
            clear_postmatch_visuals()
            with bn_postmatch_done cant_fade = false
            
            alarm[1] = earn_pauser-10
        }
    }
    
    //increment actual rank if not replaying earnings
    if not xp_replay
    {
        progression_level_up(rank)
        with net_manager
        {
            if varRead("rank") < array_length_1d(global.rank_names)-1
                varAdd("rank",1)  
                mega_stat_update("rank",varRead("rank"))
        }
        
        with net_manager.my_doll
        {
            syncVarFrom(net_manager,"rank")
        }
    }

    //AVATAR HEAD + NAMERANK
    tyoff = -64*1.5
    
    //extra yoffset in match
    if in_match() tyoff -= 48
    
    fade_delay = 0 // ---> updated in promoted_modal()
    promoted_modal(WVIEW/2,HVIEW/4+tyoff,fa_center,fa_top,1,net_manager.my_doll)
    birth_delay = 1*30
    
    slot_width = 72
    slot_scale = 1.5*slot_width/72
    
    if get_rank_unlock_sprite(rank) != spr_none and not in_match()
    {
        // "Unlocked:"
        uyoff = -12
        ID = instance_create(WVIEW/2,HVIEW/2+uyoff+tyoff,action_word)
        ID.scale = 1
        ID.halign = fa_center
        ID.fnt = fnt_hud_big
        ID.col = c_white
        ID.birth_delay = birth_delay
        ID.fade_delay = fade_delay - birth_delay
        ID.stick_2view = true
        ID.txt = "Unlocked "+bpart_lookup(get_rank_unlock_sprite(rank),global.BPART_NAME)+" Armor Set!"
        ID.init_as_promoted = true
        
        //Draw The Slot That Was Unlocked
        ID = instance_create(WVIEW/2-slot_scale*slot_width/2,HVIEW/2+32+uyoff+tyoff,action_word)
        ID.scale = slot_scale
        ID.txt = rank
        ID.rank_2unlock = rank
        ID.drawing_slot = true
        ID.birth_delay = birth_delay
        ID.fade_delay = fade_delay - birth_delay
        ID.stick_2view = true
        ID.init_as_promoted = true
    }
}

///modal window control
if (instance_exists(mw) or instance_exists(aw) or instance_exists(av_txt) or instance_exists(av_head)) and net_manager.menu_mode != "lottery_steal"
{
    if instance_exists(mw)
    with mw fade_out = true
    
    if instance_exists(aw)
        with aw fade_out = true
        
    if instance_exists(accw)
        with accw fade_out = true
        
    clear_postmatch_visuals()
        
    mw = NO_HANDLE
    aw = NO_HANDLE
    accw = NO_HANDLE

}

if net_manager.menu_mode != "lottery_steal" and not in_match()
{
    with (action_word)
    {
        if init_as_promoted and fade_time > 5
        {
            fade_time = 5
            fade_delay = 1
        }
    }
}

if instance_exists(av_txt)
{
    //av_namerank.txt = get_rank_name(rank)
    
    if in_match() and objVarRead(net_manager,"end_match_coming")
    {
        clear_postmatch_visuals()
    }
}

if instance_exists(accw) and instance_exists(bn_postmatch_done)
{
    accw.x = bn_postmatch_done.x
}

if net_manager.menu_mode = "lottery_steal" and not instance_exists(bn_postmatch_done) and room = rm_lobby
{
    bn = instance_create(room_width*1/6+64,room_height*1/4-32,bn_postmatch_done)
    
    bn.halign = fa_center
    bn.valign = fa_center
    bn.width = 64*3
    bn.height = 64*1.75
    bn.alpha_max = 0.7
    bn.color = make_colour_hsv(300,0,0)
    bn.birth_delay = 30*1.5
    bn.font = fnt_hud_big
    bn.text_valign = fa_center
    
    if instance_exists(mw)
    {
        bn.y = mw.top-mw.height/2+bn.height
    }
}

if (net_manager.lock_armory or xp_done_counter > xp_done_counter_max) and instance_exists(bn_postmatch_done)
{
    net_manager.menu_mode = "lobby"
    alarm[1] = 0
    with bn_postmatch_done fade_out = true
}

