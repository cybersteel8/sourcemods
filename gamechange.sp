#include <sourcemod>
#include <cstrike>

public Plugin myinfo = {
	name = "Gamemode Changer",
	author = "Psymon",
	description = "",
	version = "0.0.3",
	url = ""
};

public void OnPluginStart() {
	RegConsoleCmd("sm_gm", Command_Gamechange);
}

public Action Command_Gamechange(int client, int args) {
	char[] buffer = "";
	if(args > 0) {
		GetCmdArg(1, buffer, 12);
		if(StrEqual(buffer, "casual", false)) {
			SetGameMode(0);
		}
		else if(StrEqual(buffer, "wingman", false)) {
			SetGameMode(1);
		}
		else if(StrEqual(buffer, "armsrace", false)) {
			SetGameMode(2);		
		}
		else if(StrEqual(buffer, "competitive", false)) {
			SetGameMode(3);
		}
		else {
			PrintToChatAll("[SM] Invalid Argument: %s", buffer);
			PrintToServer("[SM] Invalid Argument: %s", buffer);
		}
	} else {
		PrintToServer("[SM] Showing game change menu");
		Menu menu = new Menu(ChangeMapFromMenu);
		menu.SetTitle("Choose Gamemode:");
		menu.AddItem("1", "Casual");
		menu.AddItem("2", "Wingman");
		menu.AddItem("3", "Arms Race");
		menu.AddItem("4", "Competitive");
		DisplayMenu(menu, client, 9999);
	}
	return Plugin_Handled;
}

public int ChangeMapFromMenu(Menu menu, MenuAction action, int param1, int param2) {
	if(action == MenuAction_Select) {
		PrintToServer("[SM] Menu option %d chosen", param2);
		SetGameMode(param2);
	}
}

public void SetGameMode(int mode) {
	ConVar cvGameType = FindConVar("game_type");
	ConVar cvGameMode = FindConVar("game_mode");

	switch(mode) {
		case 0: { // casual
			PrintToChatAll("[SM] Changing gamemode to Casual...");
			PrintToServer("[SM] Changing gamemode to Casual...");
			cvGameType.IntValue = 0;
			cvGameMode.IntValue = 0;
		}
		case 1: { // wingman
			PrintToChatAll("[SM] Changing gamemode to Wingman...");
			PrintToServer("[SM] Changing gamemode to Wingman...");
			cvGameType.IntValue = 0;
			cvGameMode.IntValue = 2;
		}
		case 2: { // armsrace
			PrintToChatAll("[SM] Changing gamemode to Arms Race...");
			PrintToServer("[SM] Changing gamemode to Arms Race...");
			cvGameType.IntValue = 1;
			cvGameMode.IntValue = 0;
		}
		case 3: { // competitive
			PrintToChatAll("[SM] Changing gamemode to Competitive...");
			PrintToServer("[SM] Changing gamemode to Competitive...");
			cvGameType.IntValue = 0;
			cvGameMode.IntValue = 1;
		}
	}
}
