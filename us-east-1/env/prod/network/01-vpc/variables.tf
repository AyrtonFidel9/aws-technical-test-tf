variable "cidr_block" {
  type = string
}


# Variable Tags
variable "environment" {
  description = "Describe the kind of environment in that the resources will be used (dev|uat|prod)"
}

variable "created_by" {
  description = "Person who created the resource"
}

variable "application" {
  description = "The service or application of which the resource is a component"
}

variable "cost_center" {
  description = "Useful for billing center (Human Resources | IT department)"
}

variable "contact" {
  description = "email address for the team or individual"
}

variable "maintenance_window" {
  description = "Useful for defining a window of time that resource is allows to not be available in case of parching, updates, or maintance"
}

variable "deletion_date" {
  description = "Useful for development or sandbox environments so that you know when it may be safe to delete a resource"
}
