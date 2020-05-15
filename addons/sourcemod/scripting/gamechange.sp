#include <sourcemod>
#include <cstrike>

ArrayList mapList;

public Plugin myinfo = {
	name = "Gamemode Changer",
	author = "cybersteel8",
	description = "Allows clients to change gamemode",
	version = "0.6.0",
	url = "https://github.com/cybersteel8/sourcemods/"
};

public void OnPluginStart() {
	mapList = new ArrayList(PLATFORM_MAX_PATH + 1);
	RegConsoleCmd("sm_gm", Command_Gamechange);
}

// syntax is !gm <gamemode> <mapname>
public Action Command_Gamechange(int client, int args) {
	char[] buffer = "";
	if(args > 0) {
		// Check if user provided gamemode
		GetCmdArg(1, buffer, 16);
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
		else if(StrEqual(buffer, "comp", false)) {
			SetGameMode(3, client);
		}
		else if(StrEqual(buffer, "deathmatch", false)) {
			SetGameMode(4, client);
		}
		else if(StrEqual(buffer, "dm", false)) {
			SetGameMode(4, client);
		}
		else if(StrEqual(buffer, "dangerzone", false)) {
			SetGameMode(5, client);
		}
		else if(StrEqual(buffer, "dz", false)) {
			SetGameMode(5, client);
		}
		else {
			PrintToChatAll("[GM] Invalid Argument: %s", buffer);
			PrintToServer("[GM] Invalid Argument: %s", buffer);
			return Plugin_Handled;
		}

		// Check if user also provided map choice
		if(args > 1) {
			char[] buf2 = "";
			char[] map = "";
			GetCmdArg(2, buf2, 24);
			if(StrEqual(buf2, "stay", false)) {
				PrintToServer("[GM] Staying on map!");
				GetCurrentMap(map, 24);
			} else {
				PrintToServer("[GM] Changing to %s", buf2);
				strcopy(map, 24, buf2);
			}
			PrintToServer("[GM] Calling changelevel %s", map);
			ServerCommand("changelevel %s", map);
		} else {
			// Map not provided, display changelevel menu
			ChangeMapMenu(client);
		}
	} else {
		// Gamemode not provided, display gamechange menu
		// mapchange menu is called inside the handler
		ChangeModeMenu(client);
	}
	return Plugin_Handled;
}

// Displays gamechange menu to user
public void ChangeModeMenu(client) {
	PrintToServer("[GM] Showing game change menu");
	Menu modeMenu = new Menu(ChangeModeMenuHandler);
	modeMenu.SetTitle("Choose Gamemode:");
	modeMenu.AddItem("1", "Casual");
	modeMenu.AddItem("2", "Wingman");
	modeMenu.AddItem("3", "Arms Race");
	modeMenu.AddItem("4", "Competitive");
	modeMenu.AddItem("5", "Deathmatch");
	modeMenu.AddItem("6", "Danger Zone");
	DisplayMenu(modeMenu, client, 9999);
}

// Responds to the gamechange menu prompt
public int ChangeModeMenuHandler(Menu menu, MenuAction action, int client, int selection) {
	if(action == MenuAction_Select) {
		PrintToServer("[GM] Menu option %d chosen", selection);
		SetGameMode(selection, client);
		if(selection < 5) {
			// This must be called here so it only shows after the user has selected an option in the previous menu
			// It is assumed that if the user needed the ChangeModeMenu they must need the ChangeMapMenu too.
			ChangeMapMenu(client);
		} else {
			// If Danger Zone was selected, don't show menu just change the map immediately
			ServerCommand("changelevel dz_blacksite");
		}
	}
}

// Changes the cvars based on the gamemode provided
public void SetGameMode(int mode, int client) {
	ConVar cvGameType = FindConVar("game_type");
	ConVar cvGameMode = FindConVar("game_mode");

	switch(mode) {
		case 0: { // casual
			PrintToChatAll("[GM] Changing gamemode to Casual...");
			PrintToServer("[GM] Changing gamemode to Casual...");
			cvGameType.IntValue = 0;
			cvGameMode.IntValue = 0;
		}
		case 1: { // wingman
			PrintToChatAll("[GM] Changing gamemode to Wingman...");
			PrintToServer("[GM] Changing gamemode to Wingman...");
			cvGameType.IntValue = 0;
			cvGameMode.IntValue = 2;
		}
		case 2: { // armsrace
			PrintToChatAll("[GM] Changing gamemode to Arms Race...");
			PrintToServer("[GM] Changing gamemode to Arms Race...");
			cvGameType.IntValue = 1;
			cvGameMode.IntValue = 0;
		}
		case 3: { // competitive
			PrintToChatAll("[GM] Changing gamemode to Competitive...");
			PrintToServer("[GM] Changing gamemode to Competitive...");
			cvGameType.IntValue = 0;
			cvGameMode.IntValue = 1;
		}
		case 4: { // deathmatch
			PrintToChatAll("[GM] Changing gamemode to Deathmatch...");
			PrintToServer("[GM] Changing gamemode to Deathmatch...");
			cvGameType.IntValue = 1;
			cvGameMode.IntValue = 2;
		}
		case 5: { // dangerzone
			PrintToChatAll("[GM] Changing gamemode to Danger Zone...");
			PrintToServer("[GM] Changing gamemode to Danger Zone...");
			cvGameType.IntValue = 6;
			cvGameMode.IntValue = 0;
		}
		default: {
			return;
		}
	}
}

// Prompts the user with a menu to change the map
public void ChangeMapMenu(client) {
	PrintToServer("[GM] Displaying Change Map Menu");
	Menu mapMenu = new Menu(ChangeMapMenuHandler);
	mapMenu.SetTitle("Map reload is required.");
	mapMenu.AddItem("1", "Stay on this map");
	mapMenu.AddItem("2", "Load different map");
	mapMenu.AddItem("3", "Do nothing");
	DisplayMenu(mapMenu, client, 9999);
}

// Responds to the Change Map menu prompt
public int ChangeMapMenuHandler(Menu menu, MenuAction action, int client, int selection) {
	if(action == MenuAction_Select) {
		switch(selection) {
			case 0: {
				//stay
				char[] map = "";
				GetCurrentMap(map, 64);
				PrintToServer("[GM] Calling changelevel %s", map);
				ServerCommand("changelevel %s", map);
			}
			case 1: {
				// change
				PrintToServer("[GM] Displaying maplist menu to client");
				ShowMapListMenu(client);
			}
			case 2: {
				// do nothing
			}
		}
	}
}

public void ShowMapListMenu(client) {
	char filepath[PLATFORM_MAX_PATH];
	BuildPath(Path_SM, filepath, sizeof(filepath), "configs/maplist.cfg");

	KeyValues kv = new KeyValues("maps");
	if (!kv.ImportFromFile(filepath)) {
		PrintToServer("Failed to import keyvalue from practice config file \"%s\"", filepath);
		delete kv;
		return;
	}

	char mapEntry[PLATFORM_MAX_PATH + 1];
	if(kv.JumpToKey("maps")) {
		if (kv.GotoFirstSubKey(false)) {
			do {
				kv.GetSectionName(mapEntry, sizeof(mapEntry));
				mapList.PushString(mapEntry);
			} while (kv.GotoNextKey(false));
		}
		kv.GoBack();
	}

	Menu mapMenu = new Menu(ChangeMapFromListHandler);
	mapMenu.SetTitle("Choose a map to load");
	for (int i = 0; i < mapList.Length; i++) {
		char mapName[PLATFORM_MAX_PATH];
		char menuPosition[PLATFORM_MAX_PATH];
		mapList.GetString(i, mapName, sizeof(mapName));
		IntToString(i + 1, menuPosition, sizeof(menuPosition));
		mapMenu.AddItem(menuPosition, mapName);
	}
	mapMenu.Display(client, 9999);

}

public int ChangeMapFromListHandler(Menu menu, MenuAction action, int client, int selection) {
	if(action == MenuAction_Select) {
		char map[PLATFORM_MAX_PATH];
		mapList.GetString(selection, map, sizeof(map));
		ServerCommand("changelevel %s", map);
	}
}
