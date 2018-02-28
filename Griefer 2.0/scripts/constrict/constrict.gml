/// @description constrict(var, min, max)
/// @function constrict
/// @param var
/// @param  min
/// @param  max
var datVar = argument0
var datMin = argument1
var datMax = argument2

if datVar > datMax
    datVar = datMax
    
if datVar < datMin
    datVar = datMin
    
return datVar