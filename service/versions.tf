terraform {
  required_version = ">= 1.0.7"
  required_providers {
    aws = ">= 4.20.1"
  }
  experiments = [module_variable_optional_attrs]
}
