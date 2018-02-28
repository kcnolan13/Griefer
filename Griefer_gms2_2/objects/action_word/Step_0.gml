/// @description grow/fade
if extra_delay > 0
{
    extra_delay --
    visible = false
    exit
}  

if stick_2view
{
    draw_x = x
    draw_y = y
    stuck_yet = true
}
 
if birth_delay > 0
{
    birth_delay --
    if not birth_delay
    {
        for (var i=0; i<instance_number(action_word); i++)
        {
            aw = instance_find(action_word,i)
            if aw.group_id != group_id and aw.visible and aw.alpha > 0.1 and (string_count("Kill",aw.txt) > 0 or string_count("Assist",aw.txt) > 0)
            {
                //don't come in until you're ready
                birth_delay = 2
            }
        }
    }
    visible = false
    exit
}

if not popped_in
{
    popped_in = true
    if pop_sound != snd_none
        audio(pop_sound,1)
}

visible = true

scale += growth

if not fade_delay
{
    alpha -= 1/fade_time
    if init_as_promoted
    {
        growth = 0//0.1
    }
}
else
{
    fade_delay --
    if alpha < alpha_max
        alpha += 0.08
        
    if alpha > alpha_max
    alpha = alpha_max
}

y += vmov

if alpha < 0.05
instance_destroy()

