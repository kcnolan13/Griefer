with modal_dialogue
{
    if is_checking or is_downloading
    {
        is_downloading = false
        is_checking = false
        is_launching = true
        show_percent = false
    }
}
game_exe = downloadURL[0]
printf("::: launching game: "+game_exe)
launchGame(game_exe)
controller.alarm[1] = 60*2
