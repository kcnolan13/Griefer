///rag_sort_clockwise()

var len = getLength(h)

for (var i=0; i<len; i++)
{
    htemp[i] = -999
    vtemp[i] = -999
}

var positioned = 0
var attempts = 0
var min_ang = 361
var min_ind = -1
while (positioned < len and attempts < 500)
{
    attempts++
    //find the lowest angle (for point index not already used) and add to htemp,vtemp
    min_ang = 361
    min_ind = -1
    
    for (var i=0; i<len; i++)
    {
        var considerable = true
        
        if (htemp[i] = h[i] and vtemp[i] = v[i])
            considerable = false
        
        if considerable
        {
            //printf("::: considerable")
            var pot_ang = (point_direction(0,0,h[i],v[i]) - 90) mod 360
            //new min angle?
            if pot_ang < min_ang
            {
                min_ang = pot_ang
                min_ind = i
            }
        }
    }
    
    if min_ind >= 0
    {
        //copy min ind to htemp,vtemp
        htemp[min_ind] = h[min_ind]
        vtemp[min_ind] = v[min_ind]
        positioned ++
        //printf("::: min_ang - 90 = "+string(min_ang))
    }
    else
    {
        //printf("::: failed to identify smallest angle in rag_sort_clockwise")
    }
}

if attempts > 499
{
    printf("ERROR: infinite loop in rag_sort_clockwise")
}

//write htemp,vtemp back to h,v
for (var i=0; i<len; i++)
{
    h[i] = htemp[i]
    v[i] = vtemp[i]
    
    //printf("::: h["+string(i)+"] = "+string(h[i])+", v["+string(i)+"] = "+string(v[i]))
    
}