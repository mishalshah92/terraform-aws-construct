resource "kubernetes_api_service" "metrics_apiservice" {
  metadata {
    name = var.metrics_apiservice_name
  }
  spec {
    service {
      name = kubernetes_service.server_service.metadata.0.name
      namespace = kubernetes_service.server_service.metadata.0.namespace
    }
    group = "metrics.k8s.io"
    version = "v1beta1"
    insecure_skip_tls_verify = true
    group_priority_minimum = 100
    version_priority = 100
  }
}
