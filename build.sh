#!/bin/bash

#########################################
# Stage 1: Fetching JSON values from S3 #
#########################################
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
        "StageStatus": {"S": "In-progress"} ,
        "StartTime": {"S": "'$codeBuildStartTime'"}}' \
    --return-consumed-capacity TOTAL

export codeBuildEndTime=`date +%s%N | cut -b1-13`
echo "Current timestamp is " $codeBuildEndTime
aws dynamodb update-item \
    --table-name restacking-data-store \
    --key '{"StartTime":{"S":"'$codeBuildStartTime'"}}' \
    --update-expression "SET StageStatus = :c, EndTime = :p" \
    --expression-attribute-values '{":c": {"S":"Completed"}, ":p": {"S":"'$codeBuildEndTime'"} }' \
    --return-values ALL_NEW

echo "Getting item from dynamoDB...."
touch restack.json
aws dynamodb get-item --table-name restacking-data-store --key '{"StartTime":{"S":"'$codeBuildStartTime'"}}' > restack.json
export CodeBuildId=`./jq '.CodeBuildId' restack.json`
echo "CodeBuildId is:" $CodeBuildId
#############################################
# Stage 2: Installing packer & creating AMI #
#############################################

export packerStageStartTime=`date +%s%N | cut -b1-13`

aws dynamodb put-item \
    --table-name restacking-data-store \
    --item '{
        "CodeBuildId": {"S": "'$codeBuildId'"},
        "StageName": {"S": "Installing packer & creating AMI"} ,
        "StageStatus": {"S": "In-progress"} ,
        "StartTime": {"S": "'$packerStageStartTime'"}}' \
    --return-consumed-capacity TOTAL

export packerStageEndTime=`date +%s%N | cut -b1-13`
echo "Current timestamp is " $packerStageEndTime
aws dynamodb update-item \
    --table-name restacking-data-store \
    --key '{"StartTime":{"S":"'$packerStageStartTime'"}}' \
    --update-expression "SET StageStatus = :c, EndTime = :p" \
    --expression-attribute-values '{":c": {"S":"Completed"}, ":p": {"S":"'$packerStageEndTime'"} }' \
    --return-values ALL_NEW

#########################
# Stage 3: TBT creation #
#########################

export tbtCreationStageStartTime=`date +%s%N | cut -b1-13`

aws dynamodb put-item \
    --table-name restacking-data-store \
    --item '{
        "CodeBuildId": {"S": "'$codeBuildId'"},
        "StageName": {"S": "TBT creation"} ,
        "StageStatus": {"S": "In-progress"} ,
        "StartTime": {"S": "'$tbtCreationStageStartTime'"}}' \
    --return-consumed-capacity TOTAL

export tbtCreationStageEndTime=`date +%s%N | cut -b1-13`
echo "Current timestamp is " $packerStageEndTime
aws dynamodb update-item \
    --table-name restacking-data-store \
    --key '{"StartTime":{"S":"'$tbtCreationStageStartTime'"}}' \
    --update-expression "SET StageStatus = :c, EndTime = :p" \
    --expression-attribute-values '{":c": {"S":"Completed"}, ":p": {"S":"'$tbtCreationStageEndTime'"} }' \
    --return-values ALL_NEW
