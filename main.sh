#!/bin/bash
QUEUE_DIR=./queue
ARCHIVE_DIR=./archive
LOGFILE=./log.txt
while true
do
    FIRST=$(ls -tr "$QUEUE_DIR" | head -1)
    if [ "$FIRST" ]
    then
        START_TIME=$(date '+%Y-%m-%d %H:%M:%S')
        echo "START $FIRST at $START_TIME" >> "$LOGFILE"
        bash "$QUEUE_DIR/$FIRST" >> "$LOGFILE" 2>&1
        END_TIME=$(date '+%Y-%m-%d %H:%M:%S')
        echo "END CC=$? $FIRST at $END_TIME" >> "$LOGFILE"
        mv "$QUEUE_DIR/$FIRST" "$ARCHIVE_DIR/$FIRST"
    else
        # inotifywait -e create -q "$QUEUE_DIR"
        fswatch -1 "$QUEUE_DIR"
    fi
done