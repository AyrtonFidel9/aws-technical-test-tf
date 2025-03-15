resource "aws_dynamodb_table" "uplinq_dynamodb_table" {
  name = "${var.tags.Application}-${var.tags.Environment}-inference-domain-table"

  dynamic "attribute" {
    for_each = var.attributes
    content {
      name = attribute.value["name"]
      type = attribute.value["type"]
    }    
  }

  hash_key  = var.hash_key
  range_key = var.range_key

  billing_mode   = var.billing_mode
  read_capacity  = var.read_capacity
  write_capacity = var.read_capacity

  tags = merge({
    Name = "${var.tags.Application}-${var.tags.Environment}-inference-domain-table"
  }, var.tags)
}