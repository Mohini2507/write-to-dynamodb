resource "aws_dynamodb_table_item" "example" {
  table_name = "restscking-data-store"
  hash_key   = "CodeBuildId"
  
  item = <<ITEM
{
  "CodeBuildId": {"S": var.codeBuildId},
  "StageName": {"S": "xyz"},
  "Status": {"S": "XYZ"},
  "TimeStamp": {"S": "XYZ"}
}
ITEM
}
