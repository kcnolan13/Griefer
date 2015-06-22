///generate_name(prob_preset)

shuffle_nouns(100)
shuffle_adjs(100)

//print_list(global.nouns)

randomize()
var prob_preset = argument0
var name = "sdflkjsdflkjsdflkjsdflkjsdflksjdflksdjf"
var ind = 0

while (string_length(name) > 20)
{
    var list1 = global.adjs
    var list2 = global.nouns
    
    if random(1) < 0.15
        list1 = global.nouns
    
    //pick an adjective
    do
    {
        ind = floor(random_range(0,array_length_1d(list1)-0.1))
        var adj = list1[ind]
    } until (not is_undefined(adj))
    
    //pick a noun
    do
    {
        ind = floor(random_range(0,array_length_1d(list2)-0.1))
        ind = floor(random_range(0,array_length_1d(list2)-0.1))
        var noun = list2[ind]
    } until (not is_undefined(noun))
    
    var prob_extra = 0.3
    if random(1) < 0.1
    {
        adj = ""
        prob_extra = 1
    }
    
    name = string(adj)+" "+string(noun)
    
    //maybe an extra noun
    if random(1) < prob_extra
    {
        var loop_limit = 50
        var loops = 0
        while (loops < loop_limit)
        {
            loops++
            //pick a noun
            
            if SUPER_DEBUG printf("name was: "+string(name))
            ind = floor(random_range(0,array_length_1d(global.nouns)-0.1))
            if SUPER_DEBUG printf("      ind = "+string(ind))
            ind = floor(random_range(0,array_length_1d(global.nouns)-0.1))
            ind = floor(random_range(0,array_length_1d(global.nouns)-0.1))
            if SUPER_DEBUG printf("      ind = "+string(ind))
            noun = global.nouns[ind]
            if SUPER_DEBUG printf("    noun = "+string(noun))
            
            if string_length(name+" "+string(noun)) > 20 or is_undefined(noun)
                continue
            
            name += " "+string(noun)
            if SUPER_DEBUG printf("  new name: "+string(name))
            
            break
        }
    }
    
    //with random chance, pick a preset
    if random(1) < prob_preset
    {
        ind = floor(random_range(0,array_length_1d(global.presets)-0.1))
        ind = floor(random_range(0,array_length_1d(global.presets)-0.1))
        ind = floor(random_range(0,array_length_1d(global.presets)-0.1))
        name = global.presets[ind]
    }
}

return name