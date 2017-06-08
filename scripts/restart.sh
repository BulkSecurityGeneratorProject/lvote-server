#!/usr/bin/env bash

LVOTE_PID=`ps -ef | grep '[j]ava -jar.*lvote.*.war' | awk '{ print $2 }'`

if [ -z "$LVOTE_PID" ]; then
    echo "Lvote server not started, could not be stopped"

else
	echo "Killing Lvote server PID: $LVOTE_PID ..."
	echo "kill -9 $LVOTE_PID"
	kill -9 $LVOTE_PID
	echo "Killing Lvote server"
fi

echo "Recreating db schema..."
./recreate_db_schema.sh
echo "DB schema recreated"

echo "Starting lvote server..."
echo "java -jar /lvote/lvote-server/target/lvote*.war >> /lvote/logs/server.log 2>> /lvote/logs/server.error.log &"
java -jar /lvote/lvote-server/target/lvote*.war >> /lvote/logs/server.log 2>> /lvote/logs/server.error.log &

echo "Lvote server started"
