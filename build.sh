#!/bin/bash

export codeBuildId=$(echo $CODEBUILD_BUILD_ID | awk -F":" '{print $2}')
export codeBuildStartTime=$CODEBUILD_START_TIME

echo "Code build id is " $codeBuildId
echo "Code build start time is " $CODEBUILD_START_TIME
#aws dynamodb put-item --table-name restscking-data-store --item "{""CodeBuildId"":{""S"",""12345""},""StageName"":{""S"",""abc""},""Status"":{""S"",""abc""},""TimeStamp"":{""S"",""abc""}}" --return-consumed-capacity TOTAL
aws dynamodb put-item \
    --table-name restacking-data-store \
    --item '{
        "CodeBuildId": {"S": "'$codeBuildId'"},
        "StageName": {"S": "Fetching JSON values from S3"} ,
        "Status": {"S": "In-progress"} ,
        "StartTime": {"S": "'$codeBuildStartTime'"} ,
        "EndTime": {"S": "'$codeBuildStartTime'"} }' \
    --return-consumed-capacity TOTAL

export codeBuildEndTime=${echo date +%s}

aws dynamodb update-item \
    --table-name restacking-data-store \
    --key '{"StartTime":{"S":"'$codeBuildStartTime'"}}' \
    --update-expression "SET Status = :c, Price = :p" \
    --expression-attribute-values '{":c": {"S":"Completed"}, ":p": {"S":"'$codeBuildEndTime'"} }' \
    --return-values ALL_NEW
