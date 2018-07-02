/// @description init_global_bparts()
/// @function init_global_bparts
//DS LISTS THAT HOLD BODY PART OBJECTS
global.hats = ds_list_create()
global.helmets = ds_list_create()
global.torsos = ds_list_create()
global.legs = ds_list_create()
global.shins = ds_list_create()
global.feet = ds_list_create()
global.shoulders = ds_list_create()
global.forearms = ds_list_create()
global.cache = ds_list_create()
global.yo_bparts = ds_list_create()
global.props = ds_list_create()

global.yo_bparts[| 0] = global.helmets 
global.yo_bparts[| 1] = global.torsos
global.yo_bparts[| 2] = global.legs
global.yo_bparts[| 3] = global.shins
global.yo_bparts[| 4] = global.hats
global.yo_bparts[| 5] = global.shoulders
global.yo_bparts[| 6] = global.forearms
global.yo_bparts[| 7] = global.feet
global.yo_bparts[| 8] = global.props

global.yo_bparts[| 9] = global.cache


//BODY PART LOOKUP TABLE
create_master_bparts_map()