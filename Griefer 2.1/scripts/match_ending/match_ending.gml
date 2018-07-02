/// @description match_ending()
/// @function match_ending

if net_manager.match_countdown > 0 or objVarRead(net_manager,"end_match_coming")
    return true
else return false
