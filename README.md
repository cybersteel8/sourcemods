# sourcemods
A collection of my server mods for CS:GO

---

# Manual
## Installation
### Prerequisites
You must be using the latest version of [Metamod](https://www.sourcemm.net/), [Sourcemod](https://www.sourcemod.net/) and (if using Gamechange) splewis' [PractiseMode](https://github.com/splewis/csgo-practice-mode) mod.

### Instructions
Obtain my mod from the Releases section of this repository, and place the .smx files into your `csgo/addons/sourcemod/plugins` directory on your CS server after installing the prerequisites.

## Gamechange

`!gm [casual|wingman|armsrace|competitive|deathmatch|dangerzone]`

`!gm` with no parameters will provide a menu of all the game modes currently supported for switching to. Interact with this by pressing a number on your keyboard that corresponds to the menu item on the screen. Otherwise, type in the game mode directly and skip the menu selection.

Both methods will bring up a prompt informing you that a map reload is required. This is always the case when changing game mode, otherwise CSGO will not correctly change the mode. You have the opportunity to reload the current map, or to change to a different map.
Note: If you choose to play "Danger Zone" then dz_blacksite will automatically load, as it is (currently) the only supported map.

Choosing to change map will engage splewis' `.map` command and you will proceed with his functionality to change the map. Refer to his documentation for further customization on the map list and choices.

## GOTVRec
`!rec start|stop`
`!demo start|stop`

Both commands work the same. This will send `start` and `stop` commands the GOTV bot to begin and halt recording (`tv_record` and `tv_stoprecord` commands respectively). The demos are saved in your `csgo` folder with the filename `psy_gotv_<unix-timestamp>.dem`.

---
# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## Upcoming
- [Issue #10](https://github.com/cybersteel8/sourcemods/issues/10) Map voting fix is in progress.

## [0.4.0] - 2018-12-13
### Added
- Gamechange: Map change prompt when changing game mode.
- Gamechange: Support for new Danger Zone game mode.
### Changed
- This project now uses semantic versioning.
- Info messages in chat now use mod-specific prefixes. Gamechange is [GC] and GOTVRec is [GR]. Both used to use [SM].
## [0.0.3] - 2018-08-31
### Added
- Gamechange: Deathmatch mode support
- Gamechange: Competitive mode support
- GOTVRec: !demo alias for !rec
### Fixed
- GOTVRec: timestamp now full unix format instead of missing last digit
## [0.0.2/0.0.1] - 2018-04-16
Initial version.
