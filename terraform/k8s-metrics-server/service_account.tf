resource "kubernetes_service_account" "metrics-server-deployment" {
  metadata {
    name = var.service_account_name
    namespace = var.namespace
  }
}