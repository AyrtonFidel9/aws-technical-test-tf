bucket    = "tf-state-java-springboot-ci-cd"
key       = "pipeline/terraform.tfstate"
region    = "us-east-1"
profile   = "kloud"
encrypt   = true
dynamodb_table = "ci-cd-for-terraform-state-dynamo-table"