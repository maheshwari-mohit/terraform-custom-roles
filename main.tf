provider "google" {
    project = ""
}


data "local_file" "config" {
    filename = "${path.module}/config.json"
}

# Organization custom role
# resource "google_organization_iam_custom_role" "org_custom_role" {
#   for_each    = local.platform_roles
#   role_id     = jsondecode(data.local_file.config.content)["role_id"]
#   org_id      = ""
#   title       = ""
#   description = ""
#   permissions = []
# }

# Project custom role
resource "google_project_iam_custom_role" "project_custom_role" {
  project     = jsondecode(data.local_file.config.content)["project_id"]
  role_id     = jsondecode(data.local_file.config.content)["role_id"]
  title       = jsondecode(data.local_file.config.content)["role_id"]
  description = "A description"
  permissions = jsondecode(data.local_file.config.content)["permissions"]
}