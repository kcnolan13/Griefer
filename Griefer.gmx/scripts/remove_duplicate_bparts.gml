///remove_duplicate_bparts(whitelist, duplist)
var whitelist = argument0
var duplist = argument1

if not ds_exists(whitelist,ds_type_list) or not ds_exists(duplist,ds_type_list)
{
    printf("ERROR: at least one input list does not exist to remove_duplicate_bparts")
    return false
}

var len1 = ds_list_size(whitelist)
var len2 = ds_list_size(duplist)

//var deletions = ds_list_create()

for (var i=0; i<len1; i++)
{
    var item = whitelist[| i]
    for (var j=0; j<len2; j++)
    {
        var item2 = duplist[| j]
        //printf(":::item.icon = "+string(item.icon)+", item2.icon = "+string(item2.icon))
        if instance_exists(item) and instance_exists(item2)
        {
            //printf("::: item = "+string(object_get_name(item.object_index))+", item2 = "+string(object_get_name(item2.object_index)))
            if item.icon = item2.icon and (whitelist != duplist or item.id != item2.id)
            {
                printf("::: removed duplicate bpart: "+string(sprite_get_name(item2.icon)))
                with item2 instance_destroy()
                ds_list_delete(duplist,j)
                i = -1
                len1 = ds_list_size(whitelist)
                len2 = ds_list_size(duplist)
                break
            }
        }
    }
}
