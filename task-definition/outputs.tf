output "arn" {
  value = aws_ecs_task_definition.service.arn
}

output "family" {
  value = aws_ecs_task_definition.service.family
}

output "revision" {
  value = aws_ecs_task_definition.service.revision
}

output "task_definition" {
  value = "${aws_ecs_task_definition.service.family}:${aws_ecs_task_definition.service.revision}"
}
