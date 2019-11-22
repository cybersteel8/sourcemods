#include <sourcemod>
#include <cstrike>

public Plugin myinfo = {
	name = "Command Pipe",
	author = "cyberstee8",
	description = "Allows clients to execute server commands",
	version = "0.3.0",
	url = "https://github.com/cybersteel8/sourcemods/"
};

public void OnPluginStart() {
	RegConsoleCmd("sm_cmd", Command_CmdPipe);
}

public Action Command_CmdPipe(int client, int args) {
	char[] buffer = "";
	if(args > 0) {
		GetCmdArg(1, buffer, 24);
		if(StrEqual(buffer, "kickbots", false)) {
			BotKick();
		}
		else if(StrEqual(buffer, "roundtime", false)) {
			char[] roundTime = "";
			GetCmdArg(2, roundTime, 6)
			MpRoundTime(roundTime);
		}
		else if(StrEqual(buffer, "restartgame", false)) {
			MpRestartGame();
		}
		else if(StrEqual(buffer, "endwarmup", false)) {
			MpWarmupEnd();
		}
		else if(StrEqual(buffer, "rethrow", false)) {
			Rethrow(client);
		}
		else {
			PrintToChat(client, "[CMD] Invalid Argument: %s", buffer);
			PrintToServer("[CMD] Invalid Argument: %s", buffer);
		}
	} else {
		PrintToChat(client, "[CMD] Possible commands: kickbots | roundtime [minutes] | restartgame | endwarmup | rethrow");
		PrintToServer("[CMD] Possible commands: kickbots | roundtime [minutes] | restartgame | endwarmup | rethrow");
	}
	return Plugin_Handled;
}

public void BotKick() {
	ServerCommand("bot_kick");
	PrintToChatAll("[CMD] Goodbye bots!");
	PrintToServer("[CMD] Goodbye bots!");
}

public void MpRoundTime(char[] newTime) {
	ConVar cvRoundTime = FindConVar("mp_roundtime");
	cvRoundTime.SetString(newTime);
	ConVar cvRTDefuse = FindConVar("mp_roundtime_defuse");
	cvRTDefuse.SetString(newTime);
	ConVar cvRTHostage = FindConVar("mp_roundtime_hostage");
	cvRTHostage.SetString(newTime);
	PrintToChatAll("[CMD] Round time changed to %s", newTime);
	PrintToServer("[CMD] Round time changed to %s", newTime);
}

public void MpRestartGame() {
	ServerCommand("mp_restartgame 5");
	PrintToChatAll("[CMD] Restarting game in 5 seconds...");
	PrintToServer("[CMD] Restarting game in 5 seconds...");
}

public void MpWarmupEnd() {
	ServerCommand("mp_warmup_end");
	PrintToChatAll("[CMD] Warmup ended.");
	PrintToServer("[CMD] Warmup ended.");
}

public void Rethrow(int client) {
	ConVar cvCheats = FindConVar("sv_cheats");
	int svCheats = cvCheats.IntValue;
	if(svCheats < 1) {
		PrintToChat(client, "[CMD] Rethrow requires sv_cheats to be enabled")
	} else {
		ServerCommand("sv_rethrow_last_grenade");
		PrintToChatAll("[CMD] Rethrowing last grenade!");
		PrintToServer("[CMD] Rethrowing last grenade!");
	}
}
