#!/bin/bash

export codeBuildId=$(echo $CODEBUILD_BUILD_ID | awk -F":" '{print $2}')
echo "Code build id is " $codeBuildId
#aws dynamodb put-item --table-name restscking-data-store --item "{""CodeBuildId"":{""S"",""12345""},""StageName"":{""S"",""abc""},""Status"":{""S"",""abc""},""TimeStamp"":{""S"",""abc""}}" --return-consumed-capacity TOTAL
aws dynamodb put-item \
    --table-name restscking-data-store \
    --item '{
        "CodeBuildId": {"S": "No One You Know"},
        "StageName": {"S": "$codeBuildId"} ,
        "Status": {"S": "'{$codeBuildId}'"} ,
        "TimeStamp": {"S": "Somewhat Famous"} }' \
    --return-consumed-capacity TOTAL
