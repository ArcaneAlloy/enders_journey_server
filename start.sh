#!/bin/bash

MIN_RAM=3G
MAX_RAM=4G

FORGE_VERSION=36.2.34

#if [ -z $ENDERS_JOURNEY_JAVA ]
#then
#	ENDERS_JOURNEY_JAVA=java
#fi

INSTALLER="forge-1.16.5-$FORGE_VERSION-installer.jar"
FORGE_URL="http://files.minecraftforge.net/maven/net/minecraftforge/forge/1.16.5-$FORGE_VERSION/forge-1.16.5-$FORGE_VERSION-installer.jar"

if [[ ! -f "$( dirname -- "$0"; )/forge-1.16.5-%FORGE_VERSION%.jar" ]]
then
    echo Forge is not installed, installing now...
    if [[ ! -f "$INSTALLER" ]]
	then
        echo "No Forge installer found, downloading from $FORGE_URL"
        wget "$FORGE_URL" -O "$INSTALLER"
    fi
	echo "Running Forge installer."
	java -jar $INSTALLER -installServer
fi 

while [ true ]
do
	java -Xmx$MAX_RAM -Xms$MIN_RAM -XX:+UseG1GC -XX:+ParallelRefProcEnabled -XX:MaxGCPauseMillis=200 -XX:+UnlockExperimentalVMOptions -XX:+DisableExplicitGC -XX:+AlwaysPreTouch -XX:G1NewSizePercent=30 -XX:G1MaxNewSizePercent=40 -XX:G1HeapRegionSize=32M -XX:G1ReservePercent=20 -XX:G1HeapWastePercent=5 -XX:G1MixedGCCountTarget=4 -XX:InitiatingHeapOccupancyPercent=15 -XX:G1MixedGCLiveThresholdPercent=90 -XX:G1RSetUpdatingPauseTimePercent=5 -XX:SurvivorRatio=32 -XX:+PerfDisableSharedMem -XX:MaxTenuringThreshold=1 -Dusing.aikars.flags=https://mcflags.emc.gs -Daikars.new.flags=true -jar forge-1.16.5-$FORGE_VERSION.jar nogui
	echo "Restarting automatically in 10 seconds (press Ctrl + C to cancel)"
	sleep 10
done
