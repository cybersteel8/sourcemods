# sourcemods
A collection of my server mods for CS:GO

To follow the project's changes, see the [Changelog](https://github.com/cybersteel8/sourcemods/blob/dev/CHANGELOG.md) document in this repository.

Please note that this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

---

# Manual
## Installation
### Prerequisites
You must be using the latest version of [Metamod](https://www.sourcemm.net/), [Sourcemod](https://www.sourcemod.net/) and (if using Gamechange) splewis' [PracticeMode](https://github.com/splewis/csgo-practice-mode) mod.

### Instructions
Obtain my mod from the Releases section of this repository, and place the .smx files into your `csgo/addons/sourcemod/plugins/` directory on your CS server after installing the prerequisites.

## Compiling from source
1. Download the .sp source files from the repository into your `csgo/addons/sourcemod/scripting/` directory.

2. In this directory, run `./spcomp <source-file-name>` to compile the code into a `.smx` file.

3. Move this `.smx` file into `csgo/addons/sourcemod/plugins/` and restart the server.
`sm plugins list` should have the mod you've installed listed amongst the others.

## Gamechange
`!gm [casual|wingman|armsrace|competitive|deathmatch|dangerzone]`

`!gm` with no parameters will provide a menu of all the game modes currently supported for switching to. Interact with this by pressing a number on your keyboard that corresponds to the menu item on the screen. Otherwise, type in the game mode directly and skip the menu selection.

Both methods will bring up a prompt informing you that a map reload is required. This is always the case when changing game mode, otherwise CSGO will not correctly change the mode. You have the opportunity to reload the current map, or to change to a different map.
Note: If you choose to play "Danger Zone" then dz_blacksite will automatically load, as it is (currently) the only supported map.

Choosing to change map will engage the `.map` command from the `csgo-practice-mode` mod and you will proceed with his functionality to change the map. Refer to his documentation for further customization on the map list and choices.

## GOTVRec
`!rec start|stop`
`!demo start|stop`

Both commands work the same. This will send `start` and `stop` commands the GOTV bot to begin and halt recording (`tv_record` and `tv_stoprecord` commands respectively). The demos are saved in your `csgo` folder with the filename `psy_gotv_<unix-timestamp>.dem`.
