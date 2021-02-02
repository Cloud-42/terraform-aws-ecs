resource "aws_appautoscaling_target" "ecs_target" {

  count = length(var.target_tracking_scaling_policies) > 0 ? 1 : 0

  min_capacity       = var.min_count
  max_capacity       = var.max_count
  resource_id        = "service/${var.cluster}/${var.name}"
  scalable_dimension = "ecs:service:DesiredCount"
  service_namespace  = "ecs"

  depends_on = [aws_ecs_service.this]

}

resource "aws_appautoscaling_policy" "targettracking" {

  for_each = {
    for policy in var.target_tracking_scaling_policies : policy.metric => policy
  }

  name               = "${var.cluster}-${var.name}-${each.value.metric}-TargetTracking"
  policy_type        = "TargetTrackingScaling"
  resource_id        = "service/${var.cluster}/${var.name}"
  scalable_dimension = "ecs:service:DesiredCount"
  service_namespace  = "ecs"

  target_tracking_scaling_policy_configuration {

    predefined_metric_specification {
      predefined_metric_type = each.value.metric
    }

    target_value       = each.value.target_value
    scale_in_cooldown  = each.value.scale_in_cooldown
    scale_out_cooldown = each.value.scale_out_cooldown

  }

  depends_on = [aws_appautoscaling_target.ecs_target]

}