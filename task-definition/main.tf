# -------------------------------
# Task definition
# -------------------------------
resource "aws_ecs_task_definition" "service" {
  family                   = var.family
  container_definitions    = var.container_definitions
  requires_compatibilities = var.requires_compatibilities

  cpu          = var.requires_compatibilities == ["FARGATE"] ? var.fargate_cpu : var.cpu
  memory       = var.requires_compatibilities == ["FARGATE"] ? var.fargate_memory : var.memory
  network_mode = var.requires_compatibilities == ["FARGATE"] ? "awsvpc" : var.network_mode

  task_role_arn      = var.task_role_arn
  execution_role_arn = var.execution_role_arn

  dynamic "volume" {
    for_each = var.volumes
    content {
      docker_volume_configuration                  = volume["docker_volume_configuration"]
      efs_volume_configuration                     = volume["efs_volume_configuration"]
      fsx_windows_file_server_volume_configuration = volume["fsx_windows_file_server_volume_configuration"]
      host_path                                    = volume["host_path"]
      name                                         = volume["name"]
    }
  }


  tags = var.tags
}
