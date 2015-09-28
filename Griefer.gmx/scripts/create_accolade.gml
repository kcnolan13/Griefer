///create_accolade(x,y,name,col_total)
var spawnx = argument0
var spawny = argument1
var name = argument2
var col_total = argument3

if col_total != COL_TOTAL and col_total != COL_MATCH_TOTAL and col_total != COL_BOT_TOTAL
{
    printf("ERROR: bad col_total fed to create_accolade: "+string(col_total))
}

datAcc = instance_create(spawnx,spawny,accolade_generic)
{
    datAcc.image = acc_data(name,COL_IMAGE)
    datAcc.text = acc_data(name,COL_TEXT)
    datAcc.description = acc_data(name,COL_DESCR)
    datAcc.number = acc_data(name,col_total)
    datAcc.birth_delay = 2
    datAcc.width = sprite_get_width(acc_dub_kill)/2
    datAcc.height = datAcc.width
    datAcc.text_color = c_white
    
    if in_match() and not match_ending()
    {
        datAcc.scale_normal = accolade_manager.acc_match_scale
        datAcc.scale_highlighted = accolade_manager.acc_match_scale
    }
    
    if in_match() and (not match_ending() or (object_index = accolade_manager and force_accolade_sound))
    {
        datAcc.pop_sound = acc_data(name,COL_SOUND)
    }
    
    if not in_match()
    {
        datAcc.highlight_sound = snd_scroll3
        datAcc.highlight_gain = 1//GAIN_HIGHLIGHT*1
    }   
    
    if not in_match() and menmode() = "lottery_steal"
    {
        audio(snd_pan4,GAIN_PAN)
        //datAcc.pop_sound = snd_pan3
        //datAcc.pop_gain = GAIN_PAN
    }
    
}

return datAcc
