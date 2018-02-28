/// @description end the game

save_cache()

if disconnect_on_game_end
    sendMessageReal("game_end",true)

free_all_bparts_ds()
ds_list_destroy(armory_lists)

global.rank_colors = 0
global.rank_names = 0

