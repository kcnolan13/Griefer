///insert_global_stat(pname,stat,val)
var pname = argument0
var stat = argument1
var val = argument2

if stat = "ppl"
    val = truncate(val,0)

if not instance_exists(modal_table)
{
    printf("ERROR: cannot insert_global_stat... modal table does not exist")
    return false
}

m = instance_find(modal_table,0)

if not ds_exists(m.grid,ds_type_grid) or not ds_exists(m.grid_header,ds_type_grid)
{
    printf("ERROR: cannot insert_global_stat ... modal table's grid does not exist")
    return false
}

gheight = ds_grid_height(m.grid)
gwidth = ds_grid_width(m.grid)

var row = 0
var col = 0
//find the row for this pname to insert into .... or make it!
if ds_grid_value_disk_exists(m.grid,0,1,gheight,pname)
{
    row = ds_grid_value_disk_y(m.grid,0,1,gheight,pname)
}
else
{
    row = m.rows_used+1
    m.rows_used++
}

//find the column for this stat to insert into
if ds_grid_value_disk_exists(m.grid_header,2,0,gwidth,stat)
{
    col = ds_grid_value_disk_x(m.grid_header,2,0,gwidth,stat)
}
else
{
    printf("ERROR; cannot insert_global_stat stat_name="+string(stat)+", stat column name does not exist within m.grid")
    return false
}

printf("::: writing to grid @("+string(row)+","+string(col))

//Success!! Add the stat to the table
if string(stat) = "time"
{
    //val = time_ms_2string(val,true)
}
    
ds_grid_set(m.grid,col,row,val)
