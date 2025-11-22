resource "kubernetes_deployment" "metrics_server_deployment" {
  metadata {
    name = var.metrics_server_deployment_name
    namespace = var.namespace
    labels = var.labels
  }

  spec {
    selector {
      match_labels = var.labels
    }

    template {
      metadata {
        name = var.metrics_server_deployment_name
        labels = var.labels
      }

      spec {
        service_account_name = kubernetes_service_account.metrics-server-deployment.metadata.0.name
        automount_service_account_token = true
        volume {
          name = "tmp-dir"
          empty_dir {}
        }

        container {
          name = "metrics-server"
          image = "${var.metrics_server_deployment_image}:${var.metrics_server_deployment_tag}"
          image_pull_policy = "Always"
          volume_mount {
            mount_path = "/tmp"
            name = "tmp-dir"
          }
        }

      }
    }
  }
}
