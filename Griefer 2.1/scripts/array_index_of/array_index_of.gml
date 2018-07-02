/// @description array_index_of(array,search_term))
/// @function array_index_of
/// @param array
/// @param search_term
var array = argument0
var search_term = argument1

for (var i=0; i<array_length_1d(array); i++) {
	if array[i] == search_term {
		return i
	}
}

return -1