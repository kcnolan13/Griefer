//
//  event_bindings.cpp
//
//  Created by Kyle Nolan on 5/3/2015
//
#include "event_bindings.h"

double pong_counter = 0;

void bind_events(socket::ptr &socket)
{
	socket->on("JSON_test", [&](string const& name, message::ptr const& data, bool isAck, message::ptr &ack_resp)
	{
		_lock.lock();
		console("JSON TEST!");
		double dfl = static_cast<double>(data->get_flag());
		console("flag = " + dubString(dfl));
		/*double dfl2 = static_cast<double>(data->get_map()["val2"]->get_flag());
		console("flag2 = " + dubString(dfl2));
		double val2 = getMapReal(data, "val2");
		console("val2 = " + dubString(val2));*/
		_lock.unlock();
	});

	socket->on("pkg", [&](string const& name, message::ptr const& data, bool isAck, message::ptr &ack_resp)
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
	});

	socket->on("PONG", [&](string const& name, message::ptr const& data, bool isAck, message::ptr &ack_resp){
		_lock.lock();
		pong_counter++;
		retString = "Pong Count: " + dubString(pong_counter);
		_lock.unlock();
	});

	socket->on("cancel_matchmaking", [&](string const& name, message::ptr const& data, bool isAck, message::ptr &ack_resp)
	{
		_lock.lock();
		leaveMatchMaking();
		_lock.unlock();
	});

	socket->on("heres_your_player_info", [&](string const& name, message::ptr const& data, bool isAck, message::ptr &ack_resp)
	{
		_lock.lock();
		myPlayer = data;
		console("This is me: "+getMapString(data,"pName"));
		_lock.unlock();
	});

	socket->on("you_joined_match", [&](string const& name, message::ptr const& data, bool isAck, message::ptr &ack_resp)
	{
		_lock.lock();
		myPlayer = data;
		console("JOINED MATCH! " + getMapString(myPlayer, "room"));
		_lock.unlock();
	});

	socket->on("new_player_in_group", [&](string const& name, message::ptr const& data, bool isAck, message::ptr &ack_resp)
	{
		_lock.lock();
		console(getMapString(data, "pName") + "--> joined the " + getMapString(data, "room") + "group");
		_lock.unlock();
	});

	socket->on("player_left_matchmaking", [&](string const& name, message::ptr const& data, bool isAck, message::ptr &ack_resp)
	{
		_lock.lock();
		console(getMapString(data, "pName") + " LEFT MATCHMAKING.");
		generalMessages->push_back("player_quit");
		generalValues->push_back(genVal(getMapString(data, "pName")));
		_lock.unlock();
	});

	socket->on("player_left_room", [&](string const& name, message::ptr const& data, bool isAck, message::ptr &ack_resp)
	{
		_lock.lock();
		console(getMapString(data, "pName") + "--> left your room");
		_lock.unlock();
	});

	socket->on("disconnected_player_from_server", [&](string const& name, message::ptr const& data, bool isAck, message::ptr &ack_resp)
	{
		_lock.lock();
		console(getMapString(data, "pName") + "--> EVAPORATED INTO THIN AIR");
		generalMessages->push_back("player_quit");
		generalValues->push_back(genVal(getMapString(data, "pName")));
		_lock.unlock();
	});

	socket->on("disconnect", [&](string const& name, message::ptr const& data, bool isAck, message::ptr &ack_resp)
	{
		_lock.lock();
		console("LOST CONNECTION from the server");
		generalMessages->push_back("disconnect");
		generalValues->push_back(genVal(1));
		_lock.unlock();
	});

	socket->on("obj_update", [&](string const& name, message::ptr const& data, bool isAck, message::ptr &ack_resp)
	{
		_lock.lock();
		processObjUpdate(data);
		_lock.unlock();
	});

	socket->on("obj_create", [&](string const& name, message::ptr const& data, bool isAck, message::ptr &ack_resp)
	{
		_lock.lock();
		processObjCreate(data);
		_lock.unlock();
	});

	socket->on("general_message", [&](string const& name, message::ptr const& data, bool isAck, message::ptr &ack_resp)
	{
		_lock.lock();
		console("new genMessage: "+getMapString(data,"msg"));
		processGeneralMessage(data);
		_lock.unlock();
	});

	socket->on("big_message", [&](string const& name, message::ptr const& data, bool isAck, message::ptr &ack_resp)
	{
		_lock.lock();
		console("new bigMessage: "+getMapString(data,"msg"));
		processBigMessage(data);
		_lock.unlock();
	});

}