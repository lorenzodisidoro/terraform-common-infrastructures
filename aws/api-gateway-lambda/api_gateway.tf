# Configuring API Gateway
# Configure the root "REST API" resource, the container for all of the other API Gateway methods we will create.

resource "aws_api_gateway_rest_api" "lambda_function" {
  name        = "${var.api_gateway_name}"
  description = "API Gateway for Lambda"
}

resource "aws_api_gateway_resource" "proxy" {
  rest_api_id = "${aws_api_gateway_rest_api.lambda_function.id}"
  parent_id   = "${aws_api_gateway_rest_api.lambda_function.root_resource_id}"
  path_part   = "${var.api_gateway_path_part}"
}

resource "aws_api_gateway_method" "proxy" {
  rest_api_id   = "${aws_api_gateway_rest_api.lambda_function.id}"
  resource_id   = "${aws_api_gateway_resource.proxy.id}"
  http_method   = "ANY"
  authorization = "${var.api_gateway_authorization}"
}