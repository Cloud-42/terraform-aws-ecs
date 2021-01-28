output "arn" {
  description = "ARN of the managed ECS Service."
  value       = aws_ecs_service.this.id
}

output "service" {
  description = "The ECS Service resource created by this module."
  value       = aws_ecs_service.this
}