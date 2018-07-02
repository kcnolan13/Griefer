exit;
///randomizer
if room = rm_login
{
    random_seed++
    printf("::: ADJUSTED RANDOM_SEED --> "+string(random_seed))
    
    random_set_seed(random_seed)
    
    with modal_splat
        instance_destroy()
}

