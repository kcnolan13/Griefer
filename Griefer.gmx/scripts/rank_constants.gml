//RANKS + COLORS + NAMES
global.rank_radius = 16

//poop brown for rank 0
global.rank_colors[0] = make_colour_hsv(16,69,78)
global.rank_names[0] = "Shark Bait"

val_start = 132
val_end = 50
sat_normal = 175

hue_start = 70
hue_incr = 8/2
hue = hue_start

global.rank_interval = 3

{
        names[0] = "Literal Garbage"
        names[1] = "Figurative Garbage"
        names[2] = "Victim"
        names[3] = "N00b"
        names[4] = "Plebe"
        names[5] = "Punk"
        names[6] = "Contender"
        names[7] = "Hellion"
        names[8] = "Hot-Head"
        names[9] = "Show-Boat"
        names[10] = "Brawler"
        names[11] = "Warrior"
        names[12] = "Gladiator"
        names[13] = "Juggernaut"
        names[14] = "Conquistador"
        names[15] = "Champion"
        names[16] = "Grand Champion"
        names[17] = "Legend"
        names[18] = "Myth"
        names[19] = "Nightmare"
    
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
