#!/bin/bash

aws dynamodb put-item --table-name restscking-data-store --item "{""CodeBuildId"":{""S"",""12345""},""StageName"":{""S"",""abc""},""Status"":{""S"",""abc""},""TimeStamp"":{""S"",""abc""}}" --return-consumed-capacity TOTAL
