resource "aws_dynamodb_table_item" "example" {
  table_name = "restscking-data-store"
  hash_key   = "CodeBuildId"
  codebuildid = $(echo $codeBuildId)
  item = <<ITEM
{
  "CodeBuildId": {"S": "test"},
  "StageName": {"S": "xyz"},
  "Status": {"S": "XYZ"},
  "TimeStamp": {"S": "XYZ"}
}
ITEM
}
