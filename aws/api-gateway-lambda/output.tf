output "base_url" {
  value = "${aws_api_gateway_deployment.lambda.invoke_url}/${aws_api_gateway_resource.proxy.path_part}"
}