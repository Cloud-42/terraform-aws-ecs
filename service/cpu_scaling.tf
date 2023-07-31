resource "aws_appautoscaling_target" "cpu_this" {
  count              = var.cpu_autoscaling_profile != null ? 1 : 0
  max_capacity       = var.cpu_autoscaling_profiles_config[var.cpu_autoscaling_profile].max_capacity
  min_capacity       = var.cpu_autoscaling_profiles_config[var.cpu_autoscaling_profile].min_capacity
  resource_id        = "service/${element(split("/", var.cluster), 1)}/${var.name}"
  scalable_dimension = "ecs:service:DesiredCount"
  service_namespace  = "ecs"

  depends_on = [
    aws_ecs_service.this
  ]
}

resource "aws_appautoscaling_policy" "cpu" {
  count              = var.cpu_autoscaling_profile != null ? 1 : 0
  name               = "${var.name}-cpu-scale-policy"
  policy_type        = "TargetTrackingScaling"
  resource_id        = aws_appautoscaling_target.cpu_this[0].resource_id
  scalable_dimension = aws_appautoscaling_target.cpu_this[0].scalable_dimension
  service_namespace  = aws_appautoscaling_target.cpu_this[0].service_namespace

  target_tracking_scaling_policy_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ECSServiceAverageCPUUtilization"
    }

    target_value       = var.cpu_autoscaling_profiles_config[var.cpu_autoscaling_profile].target
    scale_in_cooldown  = var.cpu_autoscaling_profiles_config[var.cpu_autoscaling_profile].scale_in_cooldown
    scale_out_cooldown = var.cpu_autoscaling_profiles_config[var.cpu_autoscaling_profile].scale_out_cooldown
  }
}


