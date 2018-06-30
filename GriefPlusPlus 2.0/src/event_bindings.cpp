//
//  event_bindings.cpp
//
//  Created by Kyle Nolan on 5/3/2015
//
#include "event_bindings.h"

double pong_counter = 0;

void bind_events(socket::ptr &socket)
{

	socket->on("keepalive", sio::socket::event_listener_aux([&](string const& name, message::ptr const& data, bool isAck, message::list &ack_resp)
	{
		_lock.lock();
		alive = 1;
		_lock.unlock();
	}));

	socket->on("pkg", sio::socket::event_listener_aux([&](string const& name, message::ptr const& data, bool isAck, message::list &ack_resp)
	{
		_lock.lock();

		//console("::: pkg!");

		//process all contained messages
		if (data->get_flag() == message::flag_array)
		{
			vector<message::ptr> vec = data->get_vector();
			for (int i = 0; i < vec.size(); i++)
			{
				message::ptr msg = vec[i];
				double dfl = static_cast<double>(msg->get_flag());
				if (msg->get_flag() == message::flag_object)
				{
					string msgName = getMapString(msg, "name");
					if (msgName == "generalMessage") {
						processGeneralMessage(msg);
					}
					else if (msgName == "bigMessage")
					{
						processBigMessage(msg);
						//console("::: bigMessage in pkg!");
					}
					else if (msgName == "objUpdate") {
						processObjUpdate(msg);
					}
					else if (msgName == "objCreate") {
						processObjCreate(msg);
					}
				}
				else { console("bad pkg object"); }
			}
		}
		else { console("MALFORMED PKG"); }
		_lock.unlock();
	}));

	socket->on("PONG", sio::socket::event_listener_aux([&](string const& name, message::ptr const& data, bool isAck, message::list &ack_resp) 
	{
		_lock.lock();
		pong_counter++;
		retString = "Pong Count: " + dubString(pong_counter);
		_lock.unlock();
	}));

	socket->on("cancel_matchmaking", sio::socket::event_listener_aux([&](string const& name, message::ptr const& data, bool isAck, message::list &ack_resp)
	{
		_lock.lock();
		leaveMatchMaking();
		_lock.unlock();
	}));

	socket->on("heres_your_player_info", sio::socket::event_listener_aux([&](string const& name, message::ptr const& data, bool isAck, message::list &ack_resp)
	{
		_lock.lock();
		myPlayer = data;
		console("This is me: "+getMapString(data,"pName"));
		_lock.unlock();
	}));

	socket->on("you_joined_match", sio::socket::event_listener_aux([&](string const& name, message::ptr const& data, bool isAck, message::list &ack_resp)
	{
		_lock.lock();
		myPlayer = data;
		console("JOINED MATCH! " + getMapString(myPlayer, "room"));
		_lock.unlock();
	}));

	socket->on("new_player_in_group", sio::socket::event_listener_aux([&](string const& name, message::ptr const& data, bool isAck, message::list &ack_resp)
	{
		_lock.lock();
		console(getMapString(data, "pName") + "--> joined the " + getMapString(data, "room") + "group");
		_lock.unlock();
	}));

	socket->on("player_left_matchmaking", sio::socket::event_listener_aux([&](string const& name, message::ptr const& data, bool isAck, message::list &ack_resp)
	{
		_lock.lock();
		console(getMapString(data, "pName") + " LEFT MATCHMAKING.");
		generalMessages->push_back("player_quit");
		generalValues->push_back(genVal(getMapString(data, "pName")));
		_lock.unlock();
	}));

	socket->on("player_left_room", sio::socket::event_listener_aux([&](string const& name, message::ptr const& data, bool isAck, message::list &ack_resp)
	{
		_lock.lock();
		console(getMapString(data, "pName") + "--> left your room");
		_lock.unlock();
	}));

	socket->on("disconnected_player_from_server", sio::socket::event_listener_aux([&](string const& name, message::ptr const& data, bool isAck, message::list &ack_resp)
	{
		_lock.lock();
		console(getMapString(data, "pName") + "--> EVAPORATED INTO THIN AIR");
		generalMessages->push_back("player_quit");
		generalValues->push_back(genVal(getMapString(data, "pName")));
		_lock.unlock();
	}));

	socket->on("disconnect", sio::socket::event_listener_aux([&](string const& name, message::ptr const& data, bool isAck, message::list &ack_resp)
	{
		_lock.lock();
		console(":::LOST CONNECTION from the server");
		generalMessages->push_back("disconnect");
		generalValues->push_back(genVal(1));
		_lock.unlock();
	}));

	socket->on("obj_update", sio::socket::event_listener_aux([&](string const& name, message::ptr const& data, bool isAck, message::list &ack_resp)
	{
		_lock.lock();
		processObjUpdate(data);
		_lock.unlock();
	}));

	socket->on("obj_create", sio::socket::event_listener_aux([&](string const& name, message::ptr const& data, bool isAck, message::list &ack_resp)
	{
		_lock.lock();
		processObjCreate(data);
		_lock.unlock();
	}));

	socket->on("general_message", sio::socket::event_listener_aux([&](string const& name, message::ptr const& data, bool isAck, message::list &ack_resp)
	{
		_lock.lock();
		console("new genMessage: "+getMapString(data,"msg"));
		processGeneralMessage(data);
		_lock.unlock();
	}));

	socket->on("big_message", sio::socket::event_listener_aux([&](string const& name, message::ptr const& data, bool isAck, message::list &ack_resp)
	{
		_lock.lock();
		console("new bigMessage: "+getMapString(data,"msg"));
		processBigMessage(data);
		_lock.unlock();
	}));


}