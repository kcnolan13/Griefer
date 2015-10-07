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

printf("::: launching game: "+downloadURL)
launchGame(downloadURL)
