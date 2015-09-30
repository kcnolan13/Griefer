///ds_grid_sort_ext(id, filter0, filter1, filter1_asc)
var original_grid = argument0
var filter0 = argument1
var filter1 = argument2
var filter1_asc = argument3
var final_grid_top
var final_grid_bottom

//initialize top and bottom segments of final grid
final_grid_top = ds_grid_create(ds_grid_width(original_grid),ds_grid_height(original_grid))
ds_grid_copy(final_grid_top,original_grid)
final_grid_bottom = ds_grid_create(ds_grid_width(original_grid),ds_grid_height(original_grid))
ds_grid_copy(final_grid_bottom,original_grid)

//sort and crop top and bottom grids
ds_grid_sort(final_grid_top,filter0,false)      //where filter0 is true
ds_grid_sort(final_grid_bottom,filter0,true)    //where filter0 is false

/*printf("::: top:")
print_ds_grid(final_grid_top)
printf("::: bottom:")
print_ds_grid(final_grid_bottom)*/

var h0 = 0
for (var i=0; i<ds_grid_height(final_grid_top); i++) {
    if (ds_grid_get(final_grid_top,filter0,i) > 0) {
        h0 ++
    }
}
var h1 = 0
for (var i=0; i<ds_grid_height(final_grid_bottom); i++) {
    if (ds_grid_get(final_grid_bottom,filter0,i) < 1) {
        h1++
    }
}

if h0 > 0
    ds_grid_resize(final_grid_top,ds_grid_width(final_grid_top),h0)

if h1 > 0
    ds_grid_resize(final_grid_bottom,ds_grid_width(final_grid_bottom),h1)

/*printf("::: top:")
print_ds_grid(final_grid_top)
printf("::: bottom:")
print_ds_grid(final_grid_bottom)*/

//sort both top and bottom by second filter
ds_grid_sort(final_grid_top,filter1,filter1_asc)
ds_grid_sort(final_grid_bottom,filter1,filter1_asc)

//recombing top and bottom to make final sorted grid
if h0 > 0
    ds_grid_set_grid_region(original_grid,final_grid_top,0,0,ds_grid_width(final_grid_top),ds_grid_height(final_grid_top),0,0)
    
if h1 > 0
    ds_grid_set_grid_region(original_grid,final_grid_bottom,0,0,ds_grid_width(final_grid_bottom),ds_grid_height(final_grid_bottom),0,ds_grid_height(final_grid_top)) 
    
//printf("::: original grid:")
//print_ds_grid(original_grid)
