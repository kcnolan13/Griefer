/// @description ambient conditions
if instance_exists(ambient_generic)
{
    ID = instance_find(ambient_generic,0)
    //glr_set_ambient_daytime(ID.time_of_day)
    //glr_set_ambient_color(ID.color)
    //glr_set_ambient_daytime_colors(ID.col_midnight,ID.col_sunrise,ID.col_noon,ID.col_afternoon,ID.col_evening)
    time_incr = ID.time_incr
}

