resource "kubernetes_role_binding" "auth-reader" {
  metadata {
    name      = "metrics-server-auth-reader"
    namespace = var.namespace
  }
  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "Role"
    name      = "extension-apiserver-authentication-reader"
  }
  subject {
    kind      = "ServiceAccount"
    name      = kubernetes_service_account.metrics-server-deployment.metadata.0.name
    namespace = kubernetes_service_account.metrics-server-deployment.metadata.0.namespace
  }
}
