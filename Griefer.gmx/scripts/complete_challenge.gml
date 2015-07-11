///complete_challenge(challenge_name)
var name = argument0
var cha = find_challenge(name)

var grav = net_manager.stat_gravatar
if not instance_exists(grav) or objVarRead(grav,"pName") != objVarRead(net_manager,"pName")
{
    printf("WARNING: cannot complete challenge while looking at another player's stats")
    return false
}

if instance_exists(cha)
{
    if not cha.completed
    {
        global.challenges_this_match ++
        cha.completed_num = global.challenges_this_match
        
        printf("CHALLENGE COMPLETE: "+string(name))
        audio_play_sound(snd_item_stolen,2,false)
        sendMessageStr("perma_challenge",name)
        cha.completed = true
        cha.new = true
        add_xp(cha.xp,true,true,false)
        /*printf("disbursing reward")
        for (var i=0; i<array_length_1d(cha.rewards); i++)
        {
            blah = instantiate_bpart(cha.rewards[i],global.src_challenge, global.cache)
            blah.txt_new = net_manager.txt_new
            blah.col_new = net_manager.col_challenge
            blah.new = true
        }*/
        return true
    }
    else
    {
        if DEBUG printf("challenge is already complete: "+name)
        return false
    }
}
else
{
    printf("ERROR: unable to locate challenge object for: "+string(name))
    return false
}
