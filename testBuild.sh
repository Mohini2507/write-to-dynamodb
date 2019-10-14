#!/bin/bash
export codeBuildStartTime=`date +%s%N | cut -b1-13`
chmod 700 ./writeInputToDBStartTime.sh
./writeInputToDBStartTime.sh $codeBuildStartTime
export codeBuildEndTime=`date +%s%N | cut -b1-13`
chmod 700 ./writeInputToDBEndTime.sh
./writeInputToDBEndTime.sh $codeBuildEndTime
