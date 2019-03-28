# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Upcoming]
- [Issue #19](https://github.com/cybersteel8/sourcemods/issues/19) - Vote confirmation before changing gamemode/map

## [0.5.0] - 2018-03-28
### Added
- CMDS: New mod. It has a bunch of convenience functions like endwarmup and kickbots. Use it in-game without parameters to see all the options. [#4](https://github.com/cybersteel8/sourcemods/issues/4)
- Gamechange: Introduced shortcut syntax! You can directly provide the gamemode then the mapname to bypass the menus altogether. Providing only the gamemode (or nothing) still triggers the necessary menus to proceed.
### Fixed
- Gamechange: selecting "stay on current map" in gamechange menu now works and reload the map correctly (finally) [#16](https://github.com/cybersteel8/sourcemods/issues/16)
- Post-match map voting now works! [#10](https://github.com/cybersteel8/sourcemods/issues/10)
- Deathmatch config should now be correctly reverted when switching to another gamemode [#18](https://github.com/cybersteel8/sourcemods/issues/18)

## [0.4.0] - 2018-12-13
### Added
- Gamechange: Map change prompt when changing game mode.
- Gamechange: Support for new Danger Zone game mode.
### Changed
- This project now uses semantic versioning.
- Info messages in chat now use mod-specific prefixes.
  - Gamechange is now prefixed with [GM]
  - GOTVRec is now prefixed with [GR].
  - No messages are provided with [SM] prefix anymore.
## [0.0.3] - 2018-08-31
### Added
- Gamechange: Deathmatch mode support
- Gamechange: Competitive mode support
- GOTVRec: !demo alias for !rec
### Fixed
- GOTVRec: timestamp now full unix format instead of missing last digit
## [0.0.2/0.0.1] - 2018-04-16
Initial version.
