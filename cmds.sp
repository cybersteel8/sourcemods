#include <sourcemod>
#include <cstrike>

public Plugin myinfo = {
	name = "Command Pipe",
	author = "cyberstee8",
	description = "",
	version = "0.0.1",
	url = ""
};

public void OnPluginStart() {
	RegConsoleCmd("sm_cmd", Command_CmdPipe);
}

public Action Command_CmdPipe(int client, int args) {
	char[] buffer = "";
	if(args > 0) {
		GetCmdArg(1, buffer, 24);
		if(StrEqual(buffer, "bot_kick", false)) {
			BotKick();
		}
		else if(StrEqual(buffer, "mp_roundtime", false)) {
			char[] roundTime = "";
			GetCmdArg(2, roundTime, 2)
			MpRoundTime(roundTime);
		}
		else if(StrEqual(buffer, "mp_restartgame", false)) {
			MpRestartGame();
		}
		else if(StrEqual(buffer, "mp_warmup_end", false)) {
			MpWarmupEnd();
		}
		else {
			PrintToChat(client, "[CMDS] Invalid Argument: %s", buffer);
			PrintToServer("[CMDS] Invalid Argument: %s", buffer);
		}
	} else {
		PrintToChat(client, "[CMDS] Possible commands: bot_kick | mp_roundtime [number] | mp_restartgame | mp_warmup_end");
		PrintToServer("[CMDS] Possible commands: bot_kick | mp_roundtime [number] | mp_restartgame | mp_warmup_end");
	}
	return Plugin_Handled;
}

public void BotKick() {
	ServerCommand("bot_kick");
	PrintToChatAll("[CMDS] Goodbye bots!");
	PrintToServer("[CMDS] Goodbye bots!");
}

public void MpRoundTime(char[] newTime) {
	ConVar cvRoundTime = FindConVar("mp_roundtime");
	cvRoundTime.SetString(newTime);
	PrintToChatAll("[CMDS] Round time changed to %s", newTime);
	PrintToServer("[CMDS] Round time changed to %s", newTime);
}

public void MpRestartGame() {
	ServerCommand("mp_restartgame 5");
	PrintToChatAll("[CMDS] Restarting game in 5 seconds...");
	PrintToServer("[CMDS] Restarting game in 5 seconds...");
}

public void MpWarmupEnd() {
	ServerCommand("mp_warmup_end");
	PrintToChatAll("[CMDS] Warmup ended.");
	PrintToServer("[CMDS] Warmup ended.");
}
