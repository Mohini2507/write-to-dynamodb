#!/bin/bash
export codeBuildStartTime=`date +%s%N | cut -b1-13`
sudo chmod 700 ./writeInputToDBStartTime.sh $codeBuildStartTime
export codeBuildEndTime=`date +%s%N | cut -b1-13`
sudo chmod 700 ./writeInputToDBEndTime.sh $codeBuildEndTime
