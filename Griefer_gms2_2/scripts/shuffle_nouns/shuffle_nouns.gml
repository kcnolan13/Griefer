/// @description shuffle_nouns(num_swaps)
/// @function shuffle_nouns
/// @param num_swaps
var num_swaps = argument0
var list = global.nouns

var swap_ind = 0

while (swap_ind < num_swaps)
{
    to = floor(random_range(0,array_length_1d(list)-0.1))
    from = floor(random_range(0,array_length_1d(list)-0.1))
    temp = list[to]
    
    global.nouns[to] = list[from]
    global.nouns[from] = temp
    
    //printf("swapped ["+to+"] and ["+from+"]")
    
    swap_ind++
}