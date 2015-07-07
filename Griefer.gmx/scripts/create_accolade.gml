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
    datAcc.width = sprite_get_width(acc_dub_kill)
    datAcc.height = datAcc.width
    
    if not match_ending()
        datAcc.pop_sound = acc_data(name,COL_SOUND)
}

return datAcc
