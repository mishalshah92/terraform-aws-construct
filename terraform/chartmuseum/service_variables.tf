variable "chart_museum_bucket" {
  type    = string
  default = "helm-charts"
}

variable "chart_museum_bucket_region" {
  type    = string
  default = "ap-south-1"
}

# chart_museum service

variable "chart_museum_docker_image_tag" {
  type    = string
  default = "latest"
}

variable "chart_museum_service_port" {
  type    = number
  default = 3000
}

variable "chart_museum_max_instances" {
  type    = number
  default = 5
}

variable "chart_museum_min_instances" {
  type    = number
  default = 1
}

variable "chart_museum_desired_instances" {
  type    = number
  default = 1
}

variable "chart_museum_health_check_response_code" {
  type = number
}

variable "chart_museum_health_check_path" {
  type = string
}