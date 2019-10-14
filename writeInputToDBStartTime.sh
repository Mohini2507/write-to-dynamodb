#!/bin/bash

####################################################
# Stage 1: Fetching JSON values from S3 start time #
####################################################
export codeBuildId=$(echo $CODEBUILD_BUILD_ID | awk -F":" '{print $2}')

echo "Code build id is " $codeBuildId

aws dynamodb put-item \
    --table-name restacking-data-store \
    --item '{
        "CodeBuildId": {"S": "'$codeBuildId'"},
        "StageName": {"S": "Fetching JSON values from S3"} ,
        "StageStatus": {"S": "In-progress"} ,
        "StartTime": {"S": "'$codeBuildStartTime'"}}' \
    --return-consumed-capacity TOTAL

