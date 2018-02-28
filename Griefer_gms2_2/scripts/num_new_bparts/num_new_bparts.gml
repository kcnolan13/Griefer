/// @description num_new_bparts()
/// @function num_new_bparts
var num_new = 0

for (var i=0; i<ds_list_size(global.cache); i++)
{
    var bpart = global.cache[| i]
    if instance_exists(bpart)
    {
        if bpart.object_index = bpart_generic
        {
            if bpart.new
                num_new++
        }
    }
}
return num_new