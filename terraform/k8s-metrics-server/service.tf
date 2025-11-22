resource "kubernetes_service" "server_service" {
  metadata {
    name = var.server_service_name
    namespace = var.namespace
    labels = {
      "kubernetes.io/name" = "Metrics-server"
      "kubernetes.io/cluster-service" = true
    }
  }
  spec {
    selector = var.labels
    port {
      port        = 443
      target_port = 443
      protocol = "TCP"
    }
  }
}