resource "aws_dynamodb_table_item" "example" {
  table_name = "restacking-data-store"
  hash_key   = "CodeBuildId"
  
  item = <<ITEM
{
  "CodeBuildId": {"S": "xyz"},
  "Stage Name": {"S": "xyz"},
  "Status": {"S": "XYZ"},
  "TimeStamp": {"S": "XYZ"}
}
ITEM
}
