
#include "./src/sio_client.h"
#include "./src/event_bindings.h"
#include "./src/receivers.h"
#include "./src/gm_readers.h"
#include "./src/gm_transmitters.h"
#include "./src/helpers.h"
//#include "./src/updater.cpp"

#include <functional>
#include <iostream>
#include <thread>
#include <mutex>
#include <condition_variable>
#include <string>
#include <stdlib.h>
#include <windows.h>
#include <deque>
#include <boost/algorithm/string/replace.hpp>

string working_directory = "";

using namespace sio;
using namespace std;

//----- GLOBALS -----//

GMEXPORT const double closeConnection()
{
	console("::: CLOSING DOWN SOCKET");
	h.clear_con_listeners();
	h.close();
	return 0;
}

//DLL INIT
GMEXPORT const double initGrieferClient(string connURL)
{
	//attempt connection
	alive = 1;
	serverURL = connURL;
	current_socket = h.socket();
    h.set_open_listener(std::bind(&connection_listener::on_connected, &l));
    h.set_close_listener(std::bind(&connection_listener::on_close, &l,std::placeholders::_1));
    h.set_fail_listener(std::bind(&connection_listener::on_fail, &l));
    h.connect(serverURL);
	console("::: connecting to: " + connURL);
	bind_events(current_socket);
	current_socket->emit("PING");
	
	return 0;
}

GMEXPORT const double downloadLatest()
{
	//DownloadURLImage(_T("http://www.puddlesquid.com/griefer/release/Griefer.exe"), _T("C:/"), NULL);
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

GMEXPORT const double keepAlive() {
	alive = 0;
	current_socket->emit("keepalive");
	return 0;
}

GMEXPORT const double isAlive() {
	if (alive == 0)
	{ 
		console("::: KeepAlive Timeout ... [but not actually closing connection]");
		//closeConnection();
	}
	return alive;
}

GMEXPORT const char * getGreeting() {
	return retString.c_str();
}

string ExePath() {
	wchar_t buffer[MAX_PATH];
	GetModuleFileName(NULL, buffer, MAX_PATH);
	wstring ws(buffer);
	string ret(ws.begin(), ws.end());

	/*size_t found = ret.find("AppData");
	ret = ret.substr(0, found + 7);*/

	return ret;
}

GMEXPORT const char *getExecPath() {
	return ExePath().c_str();
}

GMEXPORT const double setWorkingDir(char *wdir) {
	working_directory = string(wdir);
	console("::: set working directory: " + working_directory);
	return 0;
}

GMEXPORT const double updateGame(char *dir_newgame) {
	string exepath = ExePath();
	size_t found = exepath.find_last_of("\\");
	exepath = exepath.substr(0, found+1) + "Griefer.exe";

	boost::replace_all(exepath, "\\", "/");
	const char *savepath = exepath.c_str();

	console("::: working_dir = " + string(savepath));
	console("::: received dir_newgame = " + string(dir_newgame));

	wchar_t wsavepath[250];
	wchar_t wdownloadpath[250];
	mbstowcs(wdownloadpath, dir_newgame, strlen(dir_newgame) + 1);
	mbstowcs(wsavepath, savepath, strlen(savepath) + 1);
	bool success = true;

	//MessageBox(NULL, L"SavePath", wsavepath, NULL);

	if (MoveFileEx(L"Griefer.exe", L"Deprecated/Griefer_old.exe", MOVEFILE_REPLACE_EXISTING)) {
		console("::: current Griefer.exe renamed to Deprecated/Griefer_old.exe");
	}

	if (MoveFileEx(wdownloadpath, wsavepath, MOVEFILE_REPLACE_EXISTING)) {
		console("::: new Griefer.exe copied to Griefer.exe");
	}
	else {
		success = false;
	}

	if (success) {
		console("::: FILES COPIED. GAME UPDATE COMPLETE");
	}
	else {
		console("::: UPDATE FAILED.");
	}

	return 0;
}

GMEXPORT const double launchGame(char *gUrl) {
	wchar_t wgamePath[500];
	mbstowcs(wgamePath, gUrl, strlen(gUrl) + 1);

	// additional information
	STARTUPINFO si;
	PROCESS_INFORMATION pi;

	// set the size of the structures
	ZeroMemory(&si, sizeof(si));
	si.cb = sizeof(si);
	ZeroMemory(&pi, sizeof(pi));

	// start the program up
	CreateProcess(wgamePath,   // the path
		NULL,			// Command line
		NULL,           // Process handle not inheritable
		NULL,           // Thread handle not inheritable
		FALSE,          // Set handle inheritance to FALSE
		0,              // No creation flags
		NULL,           // Use parent's environment block
		NULL,           // Use parent's starting directory 
		&si,            // Pointer to STARTUPINFO structure
		&pi);           // Pointer to PROCESS_INFORMATION structure

	// Close process and thread handles. 
	CloseHandle(pi.hProcess);
	CloseHandle(pi.hThread);
	return 0;
}

GMEXPORT const double moveFile(char *file1, char *file2) {
	wchar_t fpath1[500];
	wchar_t fpath2[500];
	mbstowcs(fpath1, file1, strlen(file1) + 1);
	mbstowcs(fpath2, file2, strlen(file2) + 1);

	if (MoveFileEx(fpath1, fpath2, MOVEFILE_REPLACE_EXISTING)) {
		console("::: FILE MOVED: "+string(file1)+" --> "+string(file2));
		return 1;
	}

	return 0;
}