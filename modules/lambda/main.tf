resource "aws_iam_role" "iam_for_lambda" {
  name               = "${var.tags.Application}-${var.tags.Environment}-inference-domain-role"
  assume_role_policy = data.aws_iam_policy_document.lambda_assume_role.json
}

resource "aws_iam_policy" "policy" {
  name        = "${var.tags.Application}-${var.tags.Environment}-inference-domain-policy"
  path        = "/"
  description = "Policy for ${var.tags.Application} on ${var.tags.Environment}"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "s3:GetObject",
          "s3:PutObject",
          "s3:DeleteObject",
          "s3:ListBucket"
        ]
        Effect = "Allow"
        Resource = [
          "${var.s3_bucket_arn}",
          "${var.s3_bucket_arn}/*"
        ]
      },
      {
        Action = [
          "dynamodb:GetItem",
          "dynamodb:PutItem",
          "dynamodb:UpdateItem",
          "dynamodb:DeleteItem",
          "dynamodb:Scan",
          "dynamodb:Query"
        ]
        Effect = "Allow"
        Resource = [
          "${var.dynamodb_table_arn}"
        ]
      },
    ]
  })
}

resource "aws_iam_role_policy_attachment" "AWSLambdaVPCAccessExecutionRole" {
  role       = aws_iam_role.iam_for_lambda.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaVPCAccessExecutionRole"
}

resource "aws_iam_role_policy_attachment" "s3_dynamo_permissions" {
  role       = aws_iam_role.iam_for_lambda.name
  policy_arn = aws_iam_policy.policy.arn
}

resource "aws_security_group" "allow_traffic_from_api_gateway" {
  name        = "${var.tags.Application}-${var.tags.Environment}-inference-domain-function-sg"
  description = "Allow TLS inbound traffic and all outbound traffic"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = var.cidr_blocks
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge({
    Name = "${var.tags.Application}-${var.tags.Environment}-inference-domain-function-sg"
  }, var.tags)
}

resource "aws_lambda_function" "uplinq_lambda" {
  function_name = "${var.tags.Application}-${var.tags.Environment}-inference-domain-function"
  filename      = var.filename
  role          = aws_iam_role.iam_for_lambda.arn
  handler       = var.handler
  runtime       = var.runtime
  memory_size   = var.ram

  ephemeral_storage {
    size = var.storage
  }

  logging_config {
    log_format = "Text"
    log_group  = "/aws/lambda/${var.tags.Application}-${var.tags.Environment}-inference-domain-function"
  }
  tracing_config {
    mode = "PassThrough"
  }

  vpc_config {
    subnet_ids         = var.subnets_id
    security_group_ids = [aws_security_group.allow_traffic_from_api_gateway.id]
  }

  tags = merge({
    Name = "${var.tags.Application}-${var.tags.Environment}-inference-domain-function"
  }, var.tags)
}
