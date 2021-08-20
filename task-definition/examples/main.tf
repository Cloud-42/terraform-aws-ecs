module "task_ec2" {
  source = "git::https://github.com/Cloud-42/terraform-aws-ecs.git//task-definition?ref=v0.2.0"

  family                   = "${var.env}-${var.name}"
  container_definitions    = module.container-definition.json_map_encoded_list
  requires_compatibilities = ["EC2"]

  execution_role_arn       = module.task_execution_role.role.arn
  task_role_arn            = module.task_role.role.arn
}

module "task_fargate" {
  source = "git::https://github.com/Cloud-42/terraform-aws-ecs.git//task-definition?ref=v0.2.0"

  container_definitions = module.container-definition.json_map_encoded_list
  family                = "${var.env}-${var.name}"
  execution_role_arn    = "arn:aws:iam::${var.account_id}:role/ecsTaskExecutionRole"
  task_role_arn         = aws_iam_role.ecs_service_task.arn
  cpu                   = "512"
  memory                = "1024"
}
