# Provider
variable "availability_zone_name" {
  type    = "string"
  default = "eu-west-1"
  description = "AWS region"
}

# Lambda
variable "lambda_function_name" {
  type    = "string"
  default = "terraform_lambda_function"
}

variable "lambda_function_handler" {
  type    = "string"
  default = "main"
}

variable "lambda_function_environment_vars" {
  type    = "map"
  default = {
    foo = "bar"
  }
  description = "Environment variables of lambda"
}

variable "lambda_function_runtime" {
  type        = "string"
  default     = "go1.x"
  description = "docs.aws.amazon.com/it_it/lambda/latest/dg/lambda-runtimes.html"
}

variable "lambda_function_zip_path" {
  type    = "string"
  default = "./main.zip"
  description = "Path of lambda function zip"
}

variable "lambda_function_zip_name" {
  type    = "string"
  default = "main.zip"
  description = "Name of lambda function zip"
}

# API Gateway
variable "api_gateway_name" {
  type    = "string"
  default = "terraform_api_gateway"
}

variable "api_gateway_http_method" {
  type    = "string"
  default = "GET"
}

variable "api_gateway_authorization" {
  type    = "string"
  default = "NONE"
}

variable "api_gateway_path_part" {
  type    = "string"
  default = "my-api"
}