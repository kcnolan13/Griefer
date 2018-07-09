//
//  event_bindings.h
//
//  Created by Kyle Nolan on 5/3/2015
//

#ifndef EV_BINDINGS_H
#define EV_BINDINGS_H

#include "sio_client.h"
#include "receivers.h"
#include "gm_transmitters.h"
#include <string>
#include <functional>
#include <thread>
#include <mutex>
#include <string>
#include <stdlib.h>
#include <stdio.h>
#include <iostream>
#include <condition_variable>

#if defined(_WIN32)
# include <windows.h>
#endif

//---- GLOBALS ----//
using namespace sio;
using namespace std;

extern double pong_counter;

void bind_events(socket::ptr &socket);


#endif // __EV_BINDINGS_H__
