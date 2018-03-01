/// @description close window after game launched


ini_open("Config/GameState.ini")

if ini_key_exists("Main","GameRunning")
{
    printf("::: GameRunning Found!")
    ini_key_delete("Main","GameRunning")
    ini_close()
    game_end()
}
else
{
    //printf("::: GameRunning not found")
    ini_close()
}

action_set_alarm(60, 1);
