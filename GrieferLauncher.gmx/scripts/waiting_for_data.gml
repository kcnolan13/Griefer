///waiting_for_data()

waiting_for_dat_data = false
with modal_dialogue
{
    if is_loading
        other.waiting_for_dat_data = id
}

if waiting_for_dat_data
    return waiting_for_dat_data
else
    return false
