resource "kubernetes_cluster_role_binding" "auth_delegator" {
  metadata {
    name = "metrics-server:system:auth-delegator"
  }
  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = "system:auth-delegator"
  }
  subject {
    kind      = "ServiceAccount"
    name      = kubernetes_service_account.metrics-server-deployment.metadata.0.name
    namespace = kubernetes_service_account.metrics-server-deployment.metadata.0.namespace
  }
}

resource "kubernetes_cluster_role_binding" "resource_reader" {
  metadata {
    name = "system:metrics-server"
  }
  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = kubernetes_cluster_role.resource_reader.metadata.0.name
  }
  subject {
    kind      = "ServiceAccount"
    name      = kubernetes_service_account.metrics-server-deployment.metadata.0.name
    namespace = kubernetes_service_account.metrics-server-deployment.metadata.0.namespace
  }
}
