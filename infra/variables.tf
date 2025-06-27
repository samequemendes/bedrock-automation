variable "region" {
  type        = string
  description = "Região AWS"
}

variable "profile" {
  type        = string
  description = "Perfil AWS CLI"
}

variable "foundation_model" {
  type        = string
  description = "Modelo base para os agentes (ex: anthropic.claude-v2)"
}

variable "lambda_arn" {
  type        = string
  description = "ARN da Lambda já existente para a Action Group"
}

variable "schema_yaml_s3_uri" {
  type        = string
  description = "S3 URI do arquivo YAML com schema do Action Group"
}
