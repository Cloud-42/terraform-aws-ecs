variable "family" {
  description = "Task name, must be unique"
  type        = string
}

variable "container_definitions" {
  description = "A list of valid container definitions provided as a single valid JSON document"
}

variable "requires_compatibilities" {
  description = "Launch type. EC2 or FARGATE."
  default     = ["FARGATE"]
}

variable "fargate_cpu" {
  description = "CPU to assign to Fargate task when launch type is FARGATE"
  default     = "512"
}

variable "cpu" {
  description = "CPU to assign to Fargate task when launch type is EC2"
  default     = "512"
}

variable "fargate_memory" {
  description = "Memory to assign when launch type is FARGATE"
  default     = "1024"
}
variable "memory" {
  description = "Memory to assign when launch type is EC2"
  default     = "1024"
}

variable "tags" {
  description = "Tags map"
  type        = map(string)
  default     = {}
}

variable "network_mode" {
  description = "Network mode. The valid values are none, bridge, awsvpc, and host."
  type        = string
  default     = "none"
}

variable "task_role_arn" {
  description = "ARN of the IAM role for the task to use"
}

variable "execution_role_arn" {
  description = "ARN of the IAM role for the task to use"
}
