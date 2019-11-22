#!/bin/bash
echo ""
cp addons/sourcemod/scripting/gamechange.sp $CSGO_PATH/addons/sourcemod/scripting
echo "Copied gamechange.sp"
cp addons/sourcemod/scripting/gotvrec.sp $CSGO_PATH/addons/sourcemod/scripting
echo "Copied gotvrec.sp"
cp addons/sourcemod/scripting/cmds.sp $CSGO_PATH/addons/sourcemod/scripting
echo "Copied cmds.sp"
cp cfg/*.cfg $CSGO_PATH/cfg/
echo "Copied gamemode configs."
cp cfg/gamemodes_server.txt $CSGO_PATH/
echo "Copied gamemodes_server.txt"
echo ""
echo "----"
echo ""
cd $CSGO_PATH/addons/sourcemod/scripting/
echo "Compiling gamechange.sp"
./spcomp gamechange.sp
mv ./gamechange.smx ../plugins/
echo "Deployed gamechange.smx to plugins."
echo ""
echo "Compiling gotvrec.sp"
./spcomp gotvrec.sp
mv ./gotvrec.smx ../plugins/
echo "Deployed gotvrec.smx to plugins."
echo ""
echo "Compiling cmds.sp"
./spcomp cmds.sp
mv ./cmds.smx ../plugins/
echo "Deployed cmds.smx to plugins."
echo ""
echo "----"
echo "Deployment complete."
