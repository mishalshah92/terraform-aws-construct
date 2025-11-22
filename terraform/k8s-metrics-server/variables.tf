variable "namespace" {
  type = string
  default = "kube-system"
}

variable "server_service_name" {
  type = string
  default = "metrics-server"
}

variable "metrics_apiservice_name" {
  type = string
  default = "v1beta1.metrics.k8s.io"
}

variable "metrics_server_deployment_name" {
  type = string
  default = "metrics-server"
}

variable "labels" {
  type = map(string)
  default = {
    k8s-app = "metrics-server"
  }
}

variable "metrics_server_deployment_image" {
  type = string
  default = "k8s.gcr.io/metrics-server-amd64"
}

variable "metrics_server_deployment_tag" {
  type = string
  default = "v0.3.6"
}

variable "service_account_name" {
  type = string
  default = "metrics-server"
}