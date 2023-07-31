resource "aws_appautoscaling_target" "memory_this" {
  count              = var.memory_autoscaling_profile != null ? 1 : 0
  max_capacity       = var.memory_autoscaling_profiles_config[var.memory_autoscaling_profile].max_capacity
  min_capacity       = var.memory_autoscaling_profiles_config[var.memory_autoscaling_profile].min_capacity
  resource_id        = "service/${element(split("/", var.cluster), 1)}/${var.name}"
  scalable_dimension = "ecs:service:DesiredCount"
  service_namespace  = "ecs"

  depends_on = [
    aws_ecs_service.this
  ]
}

resource "aws_appautoscaling_policy" "memory" {
  count              = var.memory_autoscaling_profile != null ? 1 : 0
  name               = "${var.name}-memory-scale-policy"
  policy_type        = "TargetTrackingScaling"
  resource_id        = aws_appautoscaling_target.memory_this[0].resource_id
  scalable_dimension = aws_appautoscaling_target.memory_this[0].scalable_dimension
  service_namespace  = aws_appautoscaling_target.memory_this[0].service_namespace

  target_tracking_scaling_policy_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ECSServiceAverageMemoryUtilization"
    }

    target_value       = var.memory_autoscaling_profiles_config[var.memory_autoscaling_profile].target
    scale_in_cooldown  = var.memory_autoscaling_profiles_config[var.memory_autoscaling_profile].scale_in_cooldown
    scale_out_cooldown = var.memory_autoscaling_profiles_config[var.memory_autoscaling_profile].scale_out_cooldown
  }
}
