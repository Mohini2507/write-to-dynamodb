resource "aws_dynamodb_table_item" "example" {
  table_name = "restscking-data-store"
  hash_key   = "CodeBuildId"
  codeBuildIdValue = $(echo $CODEBUILD_BUILD_ID | awk -F":" '{print $2}')
  item = <<ITEM
{
  "CodeBuildId": {"S": "codeBuildIdValue"},
  "StageName": {"S": "xyz"},
  "Status": {"S": "XYZ"},
  "TimeStamp": {"S": "XYZ"}
}
ITEM
}
