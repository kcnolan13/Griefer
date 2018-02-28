/// @description click the send button(simulate press enter)
/// @function click the send button
/// @param simulate press enter

if modal_highlighted(send)
{
    event_perform(ev_keypress,vk_enter)
}

