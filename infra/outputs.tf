output "alb_dns_name" {
  description = "Endereço DNS do Application Load Balancer (ALB) da aplicação"
  value       = aws_elastic_beanstalk_environment.env.endpoint_url
}

output "iam_role_name" {
  description = "Nome da IAM Role usada pelo Beanstalk"
  value       = aws_iam_role.role.name
}

output "iam_instance_profile_name" {
  description = "Nome do IAM Instance Profile"
  value       = aws_iam_instance_profile.instance_profile.name
}
