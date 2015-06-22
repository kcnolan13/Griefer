///is_hatless(spr_helmet)
if ds_list_find_index(global.hatless,argument0) > -1
{
    //printf(argument0+" IS HATLESS")
    return true
}
else return false