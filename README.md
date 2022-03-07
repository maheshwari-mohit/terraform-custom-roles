# Terraform Custom Roles

## Prerequisites

1. Gcloud shell access
2. User running the script must have below permissions:
orgpolicy.policies.list
orgpolicy.policy.get
resourcemanager.projects.get
resourcemanager.projects.getIamPolicy
resourcemanager.projects.setIamPolicy

To run the code please follow below commands.

#### Step-0
Open cloud shell in GCloud Console

#### Step-1 
``` $ git clone https://github.com/maheshwari-mohit/terraform-custom-roles.git ```

#### Step-2 
``` cd terraform-custom-roles ```

#### Step-3 
Open config.json and fill the required values.

#### Step-4
``` $ terraform init ```

#### Step-5  => This step needs to be ran only once and when we want to import the role, otherwise skip this step.
``` $ terraform apply google_project_iam_custom_role.custom_role_import "{your project_id}/{your custom role id}" ``` 

#### Step-6
``` $ terraform apply --auto-approve ```

Now the custom role with required permission should be created.