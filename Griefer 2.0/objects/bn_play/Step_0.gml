/// @description create play modals
if net_manager.menu_mode = "play" and not instance_exists(bn_play_modal) and not instance_exists(bn_start_matchmaking) and net_manager.room_counter > 30*1.5
{
    hspacer = 128
    vspacer = 48
    width = 64*5
    height = (HVIEW-72-vspacer-2*hspacer)/2
    left = hspacer+width
    top = 72+hspacer+height
    
    
    ID = instance_create(left,top,bn_play_modal)
    ID.text = "Online "+global.cmode
    ID.color = c_black//make_colour_hsv(255*3/4,75,75)
    ID.width = width
    ID.height = height
    ID.play_bots = false
    ID.birth_delay = 3
    ID.text_halign = fa_right
    ID.text_valign = fa_bottom
    ID.font = fnt_play
    ID.image = icon_globe
    ID.img_xscale = 0.4
    ID.img_yscale = 0.4
    ID.image_xoff = 20
    ID.image_yoff = 20
    //ID.image_halign = fa_center
    //ID.image_valign = fa_center
    
    ID = instance_create(left,top+height+vspacer,bn_play_modal)
    ID.color = c_black//make_colour_hsv(255*1/3,75,75)
    ID.width = width
    ID.height = height
    ID.birth_delay = 10
    ID.text_halign = fa_right
    ID.text_valign = fa_bottom
    ID.text = "Local "+global.bmode
    ID.font = fnt_play
    ID.image = icon_bot
    ID.img_xscale = 0.4
    ID.img_yscale = 0.4
    ID.image_xoff = 20
    ID.image_yoff = 20
    //ID.image_halign = fa_center
    //ID.image_valign = fa_center
}

if net_manager.menu_mode = "play"
    play_counter ++

if net_manager.menu_mode != "play" and (instance_exists(bn_play_modal) or instance_exists(bn_start_matchmaking))
{
    play_counter = 0
    with bn_play_modal
    {
        if not popped_in visible = false
        fade_out = true
    }
    
    with bn_start_matchmaking
    {
        if not popped_in visible = false
        fade_out = true
    }
}

///create tab modals
if net_manager.menu_mode != "lottery_steal" and not instance_exists(bn_tab) and rtime() > 5 and room != rm_login
{
    tabs[0] = bn_play_tab
    tabs[1] = bn_armory
    tabs[2] = bn_challenges
    tabs[3] = bn_stats
    tabs[4] = bn_stats
    tabs[5] = bn_stats
    tabs[6] = bn_settings
    
    if net_manager.came_from_match
    tabs[7] = bn_postmatch
    
    imgs[0] = icon_play
    imgs[1] = icon_armory
    imgs[2] = icon_challenges
    imgs[3] = icon_friends
    imgs[4] = icon_friends
    imgs[5] = icon_friends
    imgs[6] = icon_settings
    
    if net_manager.came_from_match
    imgs[7] = icon_postmatch
    
    stats_start_index = 3
    
    hues[0] = 228*WEBHSV    //blue
    hues[1] = 255           //red
    hues[2] = 268*WEBHSV    //purple
    hues[3] = 210*WEBHSV    //teal
    hues[4] = 156*WEBHSV    //lime
    hues[5] = 292*WEBHSV    //pink
    hues[6] = 0             //white
    hues[7] = 148*WEBHSV
    
    hue = 0
    val = 0
    
    left = 10
    top = 5
    height = 72
    spacer = 15
    width = (WVIEW-(getLength(tabs)*spacer)-spacer/2)/getLength(tabs)
    
    //room_width - (width*(array_length_1d(tabs)-1) + 3*left)
    //spacer /= array_length_1d(tabs)
    birth_delay = 4
    
    //create the tab background modal window thing
    ID = instance_create(0,0,tab_bg_modal)
    ID.birth_delay = 1
    ID.width = room_width+10
    ID.height = height+top*2
    ID.highlightable = false
    ID.scale_born = 1
    
    for (var i=0; i<array_length_1d(tabs); i++)
    {
        ID = instance_create(left,top,tabs[i])
        ID.width = width
        ID.height = height
        ID.birth_delay = birth_delay
        
        if i=6
        {
            val = 235
            sat = 0
        }
        else
        {
            val = 195
            sat = 50
        }
        
        if i >= stats_start_index and i <= stats_start_index+2
        {
            ID.stat_tab = stat_manager.tabs[i-stats_start_index]       
        }
        
        ID.color = make_colour_hsv(hues[i],0,35)//make_colour_hsv(hues[i],sat,val)
        ID.active_color = make_colour_hsv(hues[i],sat*3,val)
        ID.hue = hues[i]
        ID.sat = sat
        ID.val = val
        
        ID.text_halign = fa_left
        ID.text_xoff = 72
        
        if net_manager.came_from_match
        {
            ID.text_xoff = 56
            ID.image_xoff = -5
        }
        
        ID.image = imgs[i]
        
        birth_delay += 3
        left += width+spacer
    }
}

if net_manager.menu_mode = "lottery_steal" and instance_exists(bn_tab)
{
    for (var i=0; i<instance_number(bn_tab); i++)
    {
        b = instance_find(bn_tab,i)
        if b.object_index != bn_postmatch_done
            b.fade_out = true
    }
    with tab_bg_modal fade_out = true
}

///create randomize modal and post-match modal
if net_manager.menu_mode = "armory" and not instance_exists(bn_randomize)
{
    tab = bn_randomize
    
    width = 72*2.5
    height = 72
    birth_delay = 1
    
    left = WVIEW-10-width
    top = HVIEW-10-height-24
    
    hue = 255
    sat = 0
    val = 0
    
    ID = instance_create(left,top,tab)
    ID.width = width
    ID.height = height
    ID.birth_delay = birth_delay
    
    ID.color = make_colour_hsv(hue,sat,val)
    ID.active_color = make_colour_hsv(hue,sat*4,125)
    
    ID.text_halign = fa_left
    ID.text_xoff = 72+5
    ID.image = icon_dice
}

///create import all
if net_manager.menu_mode = "armory" and not instance_exists(bn_import_all)
{
    tab = bn_import_all
    
    width = 24
    height = 24
    birth_delay = 1
    
    left = WVIEW/2-10+width+32
    top = net_manager.cache_y-40
    
    hue = 255
    sat = 0
    val = 0
    
    ID = instance_create(left,top,tab)
    ID.width = width
    ID.height = height
    ID.birth_delay = birth_delay
    
    ID.color = make_colour_hsv(hue,sat,val)
    ID.active_color = make_colour_hsv(hue,sat*4,125)
    
    ID.text_halign = fa_left
    ID.text_xoff = 72+5
    ID.image = icon_download
	ID.img_xscale = 24/72
	ID.img_yscale = ID.img_xscale
	ID.tooltip = "Import All"
	ID.tooltip_halign = fa_left
	ID.tooltip_xoff = -36
	ID.tooltip_yoff = ID.height/2
	ID.tooltip_width = 96
}

if net_manager.menu_mode = "armory" and ds_list_size(global.cache) < 1 and instance_exists(bn_import_all)
{
	with bn_import_all {
		alpha = 0
		birth_delay = 5
	}
}

if net_manager.menu_mode != "armory" and instance_exists(bn_randomize)
{
    with bn_randomize fade_out = true
}

if net_manager.menu_mode != "armory" and instance_exists(bn_import_all)
{
    with bn_import_all fade_out = true
}

/*

if room = rm_lobby and net_manager.menu_mode = "lobby"  and net_manager.came_from_match and not instance_exists(bn_postmatch) and instance_exists(bn_settings)
{
    if bn_settings.popped_in
    {
        tab = bn_postmatch
        
        //left = bn_settings.x + 100
        //top = 164
        left = WVIEW/2+width/2//WVIEW-10-width
        top = HVIEW/2+height/2+20//HVIEW-10-height
        width = 72*3.25
        height = 72
        birth_delay = 1
        
        hue = 90
        sat = 30
        val = 0
        
        ID = instance_create(left,top,tab)
        ID.width = width
        ID.height = height
        ID.birth_delay = birth_delay
        
        ID.color = make_colour_hsv(hue,sat,val)
        ID.active_color = make_colour_hsv(hue,sat*4,val*2)
        
        ID.text_halign = fa_left
        ID.text_xoff = 72+5
        ID.image = icon_postmatch
    }
}

if (net_manager.menu_mode != "lobby" or room != rm_lobby) and instance_exists(bn_postmatch)
{
    with bn_postmatch fade_out = true
}*/

/* */
///default behavior
event_inherited()

if timer > 0 
timer --

if clicked
clicked --

if room = rm_menu
    label = txt_menu
else
    label = txt_lobby

if label = txt_menu
{
    if net_manager.menu_mode = "play"
        active = true
    else
    {
        with (bn_start_matchmaking) instance_destroy()
        active = false
    }
}

if net_manager.menu_mode = "lottery_steal"
{
    visible = false
} else visible = true

/* */
///scale notifications

notif_scale = lerp_real(notif_scale,notif_target,notif_lerp_real)

if abs(notif_scale-notif_target) < 0.01 and not notif_pauser
{
    notif_pauser = 5
}

if notif_pauser
{
    notif_pauser --
    if not notif_pauser
    {
        if notif_target = notif_scale_min
            notif_target = notif_scale_max
        else
            notif_target = notif_scale_min
    }
}

global.notification_scale = notif_scale

/* */
/*  */
