provider "google" {
}

data "local_file" "config" {
    filename = "${path.module}/config.json"
}


# Project custom role
resource "google_project_iam_custom_role" "project_custom_role" {
  for_each = toset([for role in tolist(jsondecode(data.local_file.config.content)["new_roles"]) : jsonencode(role)])

  project     = jsondecode(data.local_file.config.content)["project_id"]
  role_id     = jsondecode(each.value)["role_id"]
  title       = jsondecode(each.value)["role_id"]
  description = jsondecode(each.value)["description"]
  permissions = jsondecode(each.value)["permissions"]
  stage       = "ALPHA"
}

# Importing custom role
resource "google_project_iam_custom_role" "custom_role_import" {
  count       = jsondecode(data.local_file.config.content)["existing_role"] == "yes" ? 1 : 0
  project     = jsondecode(data.local_file.config.content)["project_id"]
  role_id     = jsondecode(data.local_file.config.content)["existing_role"]["role_id"]
  title       = jsondecode(data.local_file.config.content)["existing_role"]["role_id"]
  description = jsondecode(data.local_file.config.content)["existing_role"]["description"]
  permissions = jsondecode(data.local_file.config.content)["existing_role"]["permissions"]
  stage       = "ALPHA"
}