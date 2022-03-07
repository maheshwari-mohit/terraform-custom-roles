provider "google" {
    project = jsondecode(data.local_file.config.content)["project_id"]
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
#   for_each = toset(jsondecode(data.local_file.config.content)["roles"])
  for_each = toset([for role in tolist(jsondecode(data.local_file.config.content)["roles"]) : jsonencode(role)])

  project     = jsondecode(data.local_file.config.content)["project_id"]
  role_id     = jsondecode(each.value)["role_id"]
  title       = jsondecode(each.value)["role_id"]
  description = "A description"
  permissions = jsondecode(each.value)["permissions"]
  stage       = "ALPHA"
}

resource "google_project_iam_custom_role" "custom_role_import" {

    project = "testing-dlp-terraform"
    role_id = "custom_role"
    title       = "title"
    description = "A description"
    permissions = ["storage.buckets.create",
                    "storage.buckets.delete","storage.buckets.get"]
}