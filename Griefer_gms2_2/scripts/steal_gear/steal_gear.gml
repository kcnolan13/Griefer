/// @description steal_gear(gear_sprite, gear_source)
/// @function steal_gear
/// @param gear_sprite
/// @param  gear_source
var gear_sprite = argument0
var gear_source = argument1

{
    blah = instantiate_bpart(gear_sprite, gear_source, global.cache)
    blah.txt_new = net_manager.txt_stolen
    blah.col_new = net_manager.col_stolen
    blah.new = true
    net_manager.bpart_transacted = blah
    
    objVarWrite(net_manager,"lost_gear",false)
    objVarWrite(net_manager,"stole_gear",true)
    objVarWrite(net_manager,"transacted_player",varRead("stolen_gear_source"))
    objVarWrite(net_manager,"stole_gear_sprite",varRead("gear_to_steal"))
    
    varWrite("gear_to_steal",false) 
    varWrite("stolen_gear_source",global.src_empty)   
}