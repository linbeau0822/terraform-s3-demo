variable "environment" {
  description = "The environment for the infrastructure"
  type        = string
}

variable "bucket_name" {
  description = "The name of the S3 bucket"
  type        = string
}

variable "root_source_path" {
  description = "The path to the root source files for the static site"
  type        = string
}