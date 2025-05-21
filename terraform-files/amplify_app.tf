resource "aws_amplify_app" "my_amplify_app" {
  name       = var.app_name
  repository = var.app_repo
  oauth_token = var.github_token 
  iam_service_role_arn = aws_iam_role.iam_role_amplify.arn

  depends_on = [aws_api_gateway_deployment.student_api_deployment]
}


resource "aws_amplify_branch" "main" {
  app_id      = aws_amplify_app.my_amplify_app.id
  branch_name = var.app_branch

  depends_on = [ aws_amplify_app.my_amplify_app ]
}

resource "aws_amplify_domain_association" "example" {
  app_id      = aws_amplify_app.my_amplify_app.id
  domain_name = var.app_domain_name


  sub_domain {
    branch_name = aws_amplify_branch.main.branch_name
    prefix      = "app"
  }

  wait_for_verification = true

  depends_on = [aws_amplify_app.my_amplify_app]
}
