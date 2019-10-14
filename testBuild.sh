#!/bin/bash

###################################################
# Stage 1: Fetching JSON values from S3 start time#
###################################################
export codeBuildStartTime=`date +%s%N | cut -b1-13`
./writeInputToDBStartTime.sh $codeBuildStartTime

#################################################
# Stage 1: Fetching JSON values from S3 end time#
#################################################
export codeBuildEndTime=`date +%s%N | cut -b1-13`
./writeInputToDBEndTime.sh $codeBuildEndTime