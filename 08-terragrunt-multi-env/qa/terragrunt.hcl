# -----------------------------------------------------------------------------
# QA Environment Terragrunt Configuration
# Inherits remote state settings from parent
# -----------------------------------------------------------------------------

include "root" {
  path = find_in_parent_folders()
}
