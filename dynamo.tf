resource "aws_dynamodb_table_item" "example" {
  table_name = "restscking-data-store"
  hash_key   = "CodeBuildId"
  
  item = <<ITEM
{
  "CodeBuildId": {"S": $(echo $CODEBUILD_BUILD_ID | awk -F":" '{print $2}')},
  "StageName": {"S": "xyz"},
  "Status": {"S": "XYZ"},
  "TimeStamp": {"S": "XYZ"}
}
ITEM
}
