#!/bin/bash

export codeBuildStartTime=`date +%s%N | cut -b1-13`
./writeInputToDBStartTime.sh $codeBuildStartTime

export codeBuildEndTime=`date +%s%N | cut -b1-13`
./writeInputToDBEndTime.sh $codeBuildEndTime
