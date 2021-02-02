#-----------------------------------------------
# AWS ECS Service
#-----------------------------------------------
resource "aws_ecs_service" "this" {

  cluster       = var.cluster
  name          = var.name
  launch_type   = var.launch_type
  desired_count = var.min_count

  task_definition = var.task_definition

  dynamic "load_balancer" {
    for_each = var.load_balancers
    content {
      container_name   = load_balancer.value["container_name"]
      container_port   = load_balancer.value["container_port"]
      target_group_arn = load_balancer.value["target_group_arn"]
    }
  }

  network_configuration {
    assign_public_ip = var.network.assign_public_ip
    security_groups  = var.network.security_groups
    subnets          = var.network.subnet_ids
  }

  propagate_tags = "TASK_DEFINITION"

  tags = var.tags

}
