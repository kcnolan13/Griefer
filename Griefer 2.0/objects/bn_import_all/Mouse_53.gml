event_inherited()

if exit_child
{
    exit_child = false
    exit
}

if visible and not net_manager.lock_armory and alpha > 0.5
{
	audio(snd_click_armory,1)
	printf("::: attempting import_all operation")
	with net_manager {
		var num_slots = max(cache_slots,ds_list_size(global.cache))
		printf("::: import_all num_slots = "+string(num_slots)+", cache_slots = "+string(cache_slots)+" ds_list_size(global.cache) = "+string(ds_list_size(global.cache)))
		for (var i=num_slots-1; i>=0; i--)
		{
			bpart = global.cache[| i]
			printf("::: import_all iteration"+string(i))
			if instance_exists(bpart) and bpart.object_index = bpart_generic {
				printf("::: Import All -- importing bpart #"+string(i))
				//add to the list this belongs in if you can
		        handle2 = get_bpart_list(bpart.limb_type)
		        handle2_index = get_bpart_list_index(bpart.limb_type)
				if not ds_exists(handle2,ds_type_list)
		        {
		            printf("ERROR: bad DS LIST handle2 in import_all cache item acquire")
		            break
		        }
				if (ds_list_size(handle2) < NUM_BPARTS and bpart.limb_type != "prop") or ds_list_size(handle2) < NUM_PROPS {
	                //simply add to gear list and delete from this list
	                current_p1 = handle2[| 0]
	                if not instance_exists(current_p1) {
	                    printf("ERROR: import_all cannot acquire cache item... handle2[| 0] doesn't exist")
	                    return false
	                }
                    if current_p1.disabled {
	                    net_manager.armory_disabled[handle2_index] = false
	                    handle2[| 0] = bpart
	                } else {
	                    ds_list_add(handle2,bpart)
	                }
					//delete from cache
	                ds_list_delete(global.cache,i)
					//synch avatar with choices(?)
	                sync_my_doll()       
	            }
	            else
	            {
	                if WARNINGS
	                    printf("WARNING: import_all found too much gear to grab from the cache")
	            }
			} else {
				printf("::: WARNING: import_all found a non-existant bpart??")
			}
		}
	}
}

with net_manager sync_my_doll()