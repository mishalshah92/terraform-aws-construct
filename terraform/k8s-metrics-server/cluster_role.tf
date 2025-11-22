resource "kubernetes_cluster_role" "aggregated_metrics_reader" {
  metadata {
    name = "system:aggregated-metrics-reader"
    labels = {
      "rbac.authorization.k8s.io/aggregate-to-view" = "true"
      "rbac.authorization.k8s.io/aggregate-to-edit" = "true"
      "rbac.authorization.k8s.io/aggregate-to-admin" = "true"
    }
  }

  rule {
    api_groups = ["metrics.k8s.io"]
    resources  = ["nodes", "pods"]
    verbs      = ["get", "list", "watch"]
  }
}

resource "kubernetes_cluster_role" "resource_reader" {
  metadata {
    name = "system:metrics-server"
  }

  rule {
    api_groups = [""]
    resources  = ["nodes", "pods", "nodes/stats", "namespaces"]
    verbs      = ["get", "list", "watch"]
  }

}

