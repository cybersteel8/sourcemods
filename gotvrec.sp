#include <sourcemod>
#include <cstrike>

char fName[10];

public Plugin myinfo = {
	name = "GOTV Recorder",
	author = "Psymon",
	description = "",
	version = "0.0.3",
	url = ""
};

public void OnPluginStart() {
	RegConsoleCmd("sm_rec", Command_GOTVRecorder);
	RegConsoleCmd("sm_demo", Command_GOTVRecorder);
}

public Action Command_GOTVRecorder(int client, int args) {
	char[] inputBuffer = "";
	if(args > 0) {
		GetCmdArg(1, inputBuffer, 12);
		if(StrEqual(inputBuffer, "start", false)) {
			ToggleRec(1);
		}
		else if(StrEqual(inputBuffer, "stop", false)) {
			ToggleRec(0);
		}
		else {
			PrintToChat(client, "[SM] Invalid Argument: %s", inputBuffer);
			PrintToServer("[SM] Invalid Argument: %s", inputBuffer);
		}
	}
	return Plugin_Handled;
}

public void ToggleRec(int rec) {
	char timeBuffer[11];
	IntToString(GetTime(), timeBuffer, 11);

	switch(rec) {
		case 0: { // stop
			PrintToChatAll("[SM] Stopping GOTV Recording...");
			PrintToServer("[SM] Stopping GOTV Recording...");
			ServerCommand("tv_stoprecord");
			PrintToChatAll("[SM] GOTV recording saved to psy_gotv_%s.dem", fName);
			PrintToServer("[SM] GOTV recording saved to psy_gotv_%s.dem", fName);
		}
		case 1: { // start
			PrintToChatAll("[SM] Starting GOTV Recording...");
			PrintToServer("[SM] Starting GOTV Recording...");
			ServerCommand("tv_record psy_gotv_%s", timeBuffer);
			fName = timeBuffer;			
		}
	}
}
