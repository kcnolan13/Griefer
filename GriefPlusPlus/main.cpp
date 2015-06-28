
#include "./src/sio_client.h"
#include "./src/event_bindings.h"
#include "./src/receivers.h"
#include "./src/gm_readers.h"
#include "./src/gm_transmitters.h"
#include "./src/helpers.h"

#include <functional>
#include <iostream>
#include <thread>
#include <mutex>
#include <condition_variable>
#include <string>
#include <stdlib.h>
#include <windows.h>
#include <deque>

using namespace sio;
using namespace std;

//----- GLOBALS -----//

void closeConnection()
{
	h.sync_close();
	h.clear_con_listeners();
}

//DLL INIT
GMEXPORT const double initGrieferClient()
{
	//attempt connection
	current_socket = h.socket();
    h.set_open_listener(std::bind(&connection_listener::on_connected, &l));
    h.set_close_listener(std::bind(&connection_listener::on_close, &l,std::placeholders::_1));
    h.set_fail_listener(std::bind(&connection_listener::on_fail, &l));
    h.connect("http://www.puddlesquid.com:8080");
	_lock.lock();

	//wait for connection
    if(!connect_finish)
    {
        _cond.wait(_lock);
    }
    _lock.unlock();

	bind_events(current_socket);
	current_socket->emit("PING");
	current_socket->emit("JSON_test","{\"val1\": 52}");

	return 0;
}

//test functions
GMEXPORT const double setGreeting(char * greeting) {
	std::string s(greeting);
	retString = s;
	popup(s.c_str());
	return 0;
}

GMEXPORT const double sendCmd(char * cmd) {
	std::string s(cmd);
	current_socket->emit("PING");
	current_socket->emit("JSON_test", "{\"val1\": 52}");
	return 0;
}

GMEXPORT const char * getGreeting() {
	return retString.c_str();
}