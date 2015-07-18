///gc_ind(gen_control_name)
var str = string(argument0)

for (var i=0; i<array_height_2d(global.gc); i++)
{
    if global.gc[i,0] = str
        return i
}

printf("ERROR: "+str+" not found in global.gc")
return -1
