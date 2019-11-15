# Serverless Applications with AWS Lambda and API Gateway

resource "aws_lambda_function" "lambda_function" {
  filename      = "${var.lambda_function_zip_name}"
  function_name = "${var.lambda_function_name}"
  role          = "${aws_iam_role.iam_for_lambda.arn}"
  handler       = "${var.lambda_function_handler}"
  source_code_hash = "${filebase64sha256(var.lambda_function_zip_path)}"

  # https://docs.aws.amazon.com/it_it/lambda/latest/dg/lambda-runtimes.html
  runtime = "${var.lambda_function_runtime}"

  environment {
    variables = "${var.lambda_function_environment_vars}"
  }
}

resource "aws_iam_role" "iam_for_lambda" {
  name = "iam_for_lambda"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_role_policy" "policy_for_lambda" {
  name        = "policy_for_lambda"
  role        = "${aws_iam_role.iam_for_lambda.id}"
  
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents",

        "kms:Decrypt",

        "s3:CreateBucket",
        "s3:GetBucketVersioning",
        "s3:GetBucketAcl",
        "s3:ListBucket",
        "s3:ListBucketMultipartUploads",
        "s3:GetObject",
        "s3:GetObjectVersion",
        "s3:GetObjectTorrent",
        "s3:PutObject",
        "s3:DeleteObject",
        
        "apigateway:*"
      ],
      "Resource": "*"
    }
  ]
}
EOF
}