variable "name" {
  type        = string
  description = "The name of the ECS Service"
}

variable "cluster" {
  type        = string
  description = "The ECS cluster to associate with the service."
}

variable "launch_type" {
  type        = string
  description = "Launch Type.  FARGATE or EC2.  Defaults to FARGATE"
  default     = "FARGATE"
}

variable "task_definition" {
  type        = string
  description = "The name of the ECS Task Definition"
}

variable "min_count" {
  type        = number
  description = "The desired (and minimum for scaling) number of tasks."
  default     = 1
}

variable "max_count" {
  type        = number
  description = "The maximum number of tasks supported with autoscaling."
  default     = 1
}

variable "network_configurations" {
  type = list(object({
    subnet_ids       = list(string)
    security_groups  = list(string)
    assign_public_ip = bool
  }))
  default = []
}

variable "load_balancers" {
  type = list(object({
    container_name   = string
    container_port   = number
    target_group_arn = string
  }))
  default = []
}

variable "tags" {
  description = "Tags map"
  type        = map(string)
  default     = {}
}
