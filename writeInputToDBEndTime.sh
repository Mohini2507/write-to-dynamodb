#!/bin/bash

##################################################
# Stage 1: Fetching JSON values from S3 end time #
##################################################

export codeBuildEndTime=`date +%s%N | cut -b1-13`
echo "Current timestamp is " $codeBuildEndTime
aws dynamodb update-item \
    --table-name restacking-data-store \
    --key '{"StartTime":{"S":"'$codeBuildStartTime'"}}' \
    --update-expression "SET StageStatus = :c, EndTime = :p" \
    --expression-attribute-values '{":c": {"S":"Completed"}, ":p": {"S":"'$codeBuildEndTime'"} }' \
    --return-values ALL_NEW