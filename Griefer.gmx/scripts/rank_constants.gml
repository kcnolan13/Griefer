//RANKS + COLORS + NAMES
global.rank_radius = 16

//poop brown for rank 0
global.rank_colors[0] = make_colour_hsv(16,69,78)
global.rank_names[0] = "Shark Bait"

val_start = 132
val_end = 50
sat_normal = 175

hue_start = 70
hue_incr = 8
hue = hue_start

global.rank_interval = 3

{
        names[0] = "Neophyte"
        names[1] = "Recruit"
        names[2] = "Provocator"
        names[3] = "Contender"
        names[4] = "Brawler"
        names[5] = "Warrior"
        names[6] = "Juggernaut"
        names[7] = "Champion"
        names[8] = "Grand Champion"
        names[9] = "Legend"
        names[10] = "Myth"
        names[11] = "Nightmare"
        global.dice_divisor[0] = 1
        global.dice_divisor[1] = 1.5
        global.dice_divisor[2] = 2
        global.dice_divisor[3] = 2.5
        global.dice_divisor[4] = 2.75
        global.dice_divisor[5] = 3
        global.dice_divisor[6] = 3
        global.dice_divisor[7] = 3.25
        global.dice_divisor[8] = 3.5
        global.dice_divisor[9] = 3.75
        global.dice_divisor[10] = 4
        global.dice_divisor[11] = 4
        global.dice_divisor[12] = 4.25
        global.dice_divisor[13] = 4.5
        global.dice_divisor[14] = 6
    
    rank = 1
    rank_cat = 0
    hue_looped = false
    //make all dose colors
    for (var j=0; j<array_length_1d(names); j++)
    {
        for (var i=0; i < global.rank_interval; i++)
        {
            if rank_cat=0
                sat = 0
            else
                sat = sat_normal
                
            val = val_start-i*(val_start-val_end)/global.rank_interval
            
            numeral=""
            if i<3
            {
                repeat(i+1) numeral += "I"
            }
            else if i=3 numeral += "IV"
            else if i=4 numeral += "V"
            
            global.rank_names[rank] = names[rank_cat]+" "+numeral
            global.rank_colors[rank] = make_colour_hsv(hue, sat, val)
            printf(""+string(rank)+": "+global.rank_names[rank]+": h="+string(hue)+" s="+string(sat)+" v="+string(val))
            
            hue += hue_incr
            if hue > 240
            {
                hue = 0
                hue_looped = true
            }
            
            if hue > global.rank_interval and hue_looped = true
            {
                //go black from here on out
                val_start = 0
                val_end = 0
            }
            
            rank++
            
        }
        
        rank_cat ++
    }
}