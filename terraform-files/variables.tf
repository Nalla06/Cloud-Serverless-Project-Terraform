variable "app_name" {}
variable "app_repo" {}
variable "app_branch" {}
variable "app_domain_name" {}
variable "db_table_name" {}
variable "function_name_GET" {}
variable "bucket_name" {}
variable "GET_function_file" {}
variable "function_name_POST" {}
variable "POST_function_file" {}
variable "GET_lambda_handler" {}
variable "POST_lambda_handler" {}
variable "lambda_runtime" {}
variable "lambda_timeout" {}
variable "lambda_memory_size" {}
variable "rest_api_name" {}
variable "rest_api_description" {}
variable "api_resource_one" {}
variable "api_resource_two" {}
variable "role-1" {}
variable "role-2" {}
variable "policy-1" {}
variable "policy-2" {}
variable "github_token" {
  description = "GitHub OAuth token for Amplify to access the repository"
  type        = string
  sensitive   = true
}
