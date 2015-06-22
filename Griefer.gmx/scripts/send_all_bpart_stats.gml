///send_all_bpart_stats()
var_strs[0] = "helmet"
var_strs[1] = "torso"
var_strs[2] = "leg"
var_strs[3] = "shin"
var_strs[4] = "hat"
var_strs[5] = "shoulder"
var_strs[6] = "forearm"
var_strs[7] = "foot"
var_strs[8] = "prop"

if DEBUG
    printf("SENDING ALL BPART STATS TO SERVER")
    
var statement = "UPDATE users SET "

for (var i=0; i<NUM_LIMBS; i++)
{
    //printf("i="+i)
    handle = global.yo_bparts[| i]
    //printf("snagged handle")
    if not ds_exists(handle,ds_type_list)
    {
        printf("CRITICAL ERROR: full netstat synchronization failed: bad DS List handle")
        return false
    }
    
    for (var j=0; j<NUM_BPARTS; j++)
    {
        
        if j < ds_list_size(handle)
        {
            var part = handle[| j]
            if instance_exists(part) and part.object_index = bpart_generic
            {
                //printf("-----"+i+": sending "+handle[| j].icon+" at limb "+i+", position "+j)
                statement += string(var_strs[i]+string(j))+"='"+string(num2string_digits(part.icon,4))+"_"+string(part.source)+"'"
                if i<NUM_LIMBS-1 or j<NUM_BPARTS-1
                    statement += ", "
                //stat_update_string(var_strs[i]+j,num2string_digits(handle[| j].icon,4)+"_"+handle[| j].source,FL_NORMAL)
            } else
            {
                if not instance_exists(part)
                    printf("handle[| j] DOES NOT EXIST")
                else
                    printf("handle[| j].object_index = "+string(part.object_index))
            }
            
        }
        else
        {
           // printf("------------BPART DS LIST "+i+": sending empty slot at  limb "+i+", position "+j)
            statement += string(var_strs[i]+string(j))+"='"+string(global.spr_empty)+"_"+string(global.src_empty)+"'"
            if i<NUM_LIMBS-1 or j<NUM_BPARTS-1
                statement += ", "
            //stat_update_string(var_strs[i]+j,global.spr_empty+"_"+global.src_empty,FL_NORMAL)
        }
    }
}

//now send this composed SQL statement all as one!!!
statement += " WHERE username='"+string(objVarRead(net_manager,"pName"))+"';"
printf(statement)
stat_update_string(statement,0,FL_SQL)

if DEBUG
    printf("BPART STATS SENT SUCCESSFULLY")
return true