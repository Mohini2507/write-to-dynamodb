#!/bin/bash

export codeBuildStartTime=`date +%s%N | cut -b1-13`
chmod +x writeInputToDBStartTime.sh
./writeInputToDBStartTime.sh $codeBuildStartTime

export codeBuildEndTime=`date +%s%N | cut -b1-13`
chmod +x writeInputToDBEndTime.sh
./writeInputToDBEndTime.sh $codeBuildEndTime
