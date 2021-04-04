resource "aws_iam_saml_provider" "gsuite_saml_app" {
  name                   = "Gsuite"
  saml_metadata_document = file("${path.module}/configs/gsuite_saml.xml")
}