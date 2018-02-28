/// @description all dat ish
if not modal_highlighted(id)
{
    exit_child = true
    exit
}

if clicked exit
    clicked = 2

printf("clicked: "+label)
audio(snd_click,1)

if instance_exists(parent_table)
{
    if is_top
        parent_table.s_index = 0
    else
        parent_table.s_index = parent_table.s_index_max
}

