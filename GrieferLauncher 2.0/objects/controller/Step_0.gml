/// @description receive transmissions
wait_counter = 0
life++

if life > room_speed*1.5
while (genMessagesWaiting() and wait_counter < 500000)
{
    receptions++
    
    wait_counter++
    genMessage = readGenMessage()
    if (isString("genMessage"))
        genVal = readGenValStr()
    else
        genVal = readGenValReal()
        
        //printf(genMessage+": "+genVal)
        
    switch (genMessage)
    {
        case "ack":
            packets_received++
        break
        
        case "validate_hash":
        
            official_server_hash = string(genVal)
            
            if string(hash) != official_server_hash
            {
                printf("::: updates are needed!")
                download_updates()
            }
            else 
            {
                printf("::: game version is current! no updates needed")
                launch_game()
            }
        break   
        
        case "done_loading":
            if global.load_count > 0 global.load_count --
            else global.load_count = 0
            
            printf("::: Done Loading! global.load_count --> "+string(global.load_count))
            
            if not global.load_count
            {
                with modal_dialogue
                {
                    if is_loading and not is_downloading
                    {
                        fade_delay = 5
                    }
                }
            }
        break
        
        case "disconnect":
            printf(":::RECEIVED SERVER DISCONNECT")
            server_found = false
            //griefer_restart()
        break
        
    }
}

///keepalive

///keepalive and force sync and full_screen sync and draw_you_killed

if reconnect_timer > 0
{
    reconnect_timer -= 0.5//= sub_real(reconnect_timer,1)
    if not reconnect_timer
    {
        try_server_reconnect()
    }
}

if keepalive_timer
{
    keepalive_timer --
    if not keepalive_timer
    {
        keepalive_timer = keepalive_timeout
        //printf("::: checking keepalive")
        if isAlive() = 1
        {
            //printf(":::IS ALIVE")
            server_found = true
            keepalive_missed = 0
            keepAlive()
        }
        else
        {
            keepalive_missed ++
            printf("::: KEEPALIVE TIMEOUT")
            keepAlive()
            
            if keepalive_missed > keepalive_missable
            {
                server_found = false
            }
        }
    }
}

