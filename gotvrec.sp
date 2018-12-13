#include <sourcemod>
#include <cstrike>

char fName[10];

public Plugin myinfo = {
	name = "GOTV Recorder",
	author = "cybersteel8",
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
			PrintToChat(client, "[GR] Invalid Argument: %s", inputBuffer);
			PrintToServer("[GR] Invalid Argument: %s", inputBuffer);
		}
	}
	return Plugin_Handled;
}

public void ToggleRec(int rec) {
	char timeBuffer[11];
	IntToString(GetTime(), timeBuffer, 11);

	switch(rec) {
		case 0: { // stop
			PrintToChatAll("[GR] Stopping GOTV Recording...");
			PrintToServer("[GR] Stopping GOTV Recording...");
			ServerCommand("tv_stoprecord");
			PrintToChatAll("[GR] GOTV recording saved to psy_gotv_%s.dem", fName);
			PrintToServer("[GR] GOTV recording saved to psy_gotv_%s.dem", fName);
		}
		case 1: { // start
			PrintToChatAll("[GR] Starting GOTV Recording...");
			PrintToServer("[GR] Starting GOTV Recording...");
			ServerCommand("tv_record psy_gotv_%s", timeBuffer);
			fName = timeBuffer;
		}
	}
}
