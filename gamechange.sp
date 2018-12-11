#include <sourcemod>
#include <cstrike>

public Plugin myinfo = {
	name = "Gamemode Changer",
	author = "cyberstee8",
	description = "",
	version = "0.0.6",
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
			SetGameMode(0, client);
		}
		else if(StrEqual(buffer, "wingman", false)) {
			SetGameMode(1, client);
		}
		else if(StrEqual(buffer, "armsrace", false)) {
			SetGameMode(2, client);
		}
		else if(StrEqual(buffer, "competitive", false)) {
			SetGameMode(3, client);
		}
		else if(StrEqual(buffer, "deathmatch", false)) {
			SetGameMode(4, client);
		}
		else if(StrEqual(buffer, "survival", false)) {
			SetGameMode(5, client);
		}
		else {
			PrintToChatAll("[SM] Invalid Argument: %s", buffer);
			PrintToServer("[SM] Invalid Argument: %s", buffer);
		}
	} else {
		PrintToServer("[SM] Showing game change menu");
		Menu modeMenu = new Menu(ChangeModeFromMenu);
		modeMenu.SetTitle("Choose Gamemode:");
		modeMenu.AddItem("1", "Casual");
		modeMenu.AddItem("2", "Wingman");
		modeMenu.AddItem("3", "Arms Race");
		modeMenu.AddItem("4", "Competitive");
		modeMenu.AddItem("5", "Deathmatch");
		modeMenu.AddItem("6", "Survival");
		DisplayMenu(modeMenu, client, 9999);
	}
	return Plugin_Handled;
}

public int ChangeModeFromMenu(Menu menu, MenuAction action, int client, int selection) {
	if(action == MenuAction_Select) {
		PrintToServer("[SM] Menu option %d chosen", selection);
		SetGameMode(selection, client);
	}
}

public void SetGameMode(int mode, int client) {
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
		case 4: { // deathmatch
			PrintToChatAll("[SM] Changing gamemode to Deathmatch...");
			PrintToServer("[SM] Changing gamemode to Deathmatch...");
			cvGameType.IntValue = 1;
			cvGameMode.IntValue = 2;
		}
		case 5: { // survival
			PrintToChatAll("[SM] Changing gamemode to Survival...");
			PrintToServer("[SM] Changing gamemode to Survival...");
			cvGameType.IntValue = 6;
			cvGameMode.IntValue = 0;
			ServerCommand("changelevel dz_blacksite");
			return;
		}
		default: {
			return;
		}
	}

	// Display changelevel prompt
	PrintToServer("[SM] Displaying Change Map Menu");
	Menu mapMenu = new Menu(ChangeMapPromptHandler);
	mapMenu.SetTitle("Map reload is required.");
	mapMenu.AddItem("1", "Stay on this map");
	mapMenu.AddItem("2", "Load different map");
	mapMenu.AddItem("3", "Do nothing");
	DisplayMenu(mapMenu, client, 9999);
}

public int ChangeMapPromptHandler(Menu menu, MenuAction action, int client, int selection) {
	if(action == MenuAction_Select) {
		switch(selection) {
			case 0: {
				//stay
				ServerCommand("changelevel %s", currentMap());
			}
			case 1: {
				// change
				PrintToServer("[SM] Displaying sm_practicemap menu to client");
				ClientCommand(client, "sm_practicemap");
			}
			case 2: {
				// do nothing
			}
		}
	}
}

char[] currentMap() {
	char[] buffer = "";
	GetCurrentMap(buffer, 64);
	PrintToServer("[SM] GetCurrentMap returned: %s", buffer);
	return buffer;
}
