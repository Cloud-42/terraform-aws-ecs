## terraform_aws_ecs_task_definition

When applied this module will create the following resources:

* AWS ECS Service
* AWS Autoscaling Target
* AWS Autoscaling Policy

## Dependencies and Prerequisites

* Terraform > 0.13.2 
* AWS provider > 3.7 
* AWS account

## Variables

### Service

| Variable | Meaning | Optional |
| :------- | :----- | :----- |
| name | Name of the service | No |
| cluster | Name of the cluster | No |
| launch_type | Launch Type.  FARGATE or EC2.  Defaults to FARGATE. | Yes |
| task_definition | Name of the task definition | Yes |
| min_count | The minimum or desired number of tasks. Defaults to 1 | Yes |
| max_count | The maximum number of tasks supported with autoscaling. Defaults to 1 | Yes |
| network | Network configuration object | No |
| load_balancers | Load balancers configuration object | No |
| target_tracking_scaling_policies | Target tracking scaling policies configuration object | No |
| tags | Tags map | No |

### Network Configuration

| Variable | Meaning | Optional |
| :------- | :----- | :----- |
| vpc_id | ID of the VPC | No |
| subnet_ids | Subnet IDs | No |
| security_groups | Security Group names | No |
| assign_public_ip | Assign a public IP | No |

### Load Balancers Configuration

| Variable | Meaning | Optional |
| :------- | :----- | :----- |
| container_name | The name of the container to associate with the load balancer | No |
| container_port | The port on the container to associate with the load balancer | No |
| target_group_arn | The ARN of the Load Balancer target group to associate with the service | No |

### Target Tracking Scaling Policy Configuration

| Variable | Meaning | Optional |
| :------- | :----- | :----- |
| metric | The metric type. e.g. ECSServiceAverageCPUUtilization, ECSServiceAverageMemoryUtilization, ALBRequestCountPerTarget | No |
| target_value | The target value for the metric. e.g. 70 | No |
| scale_in_cooldown | The amount of time, in seconds, after a scale in activity completes before another scale in activity can start. | No |
| scale_out_cooldown |  The amount of time, in seconds, after a scale out activity completes before another scale out activity can start. | No |

## Outputs
| Output | Description |
| :------- | :----- |
| arn | ARN of the managed ECS Service. |
| service | The ECS Service resource created by this module. |

## Usage

To import the module add the following to the your TF file:
```
module "my_ecs_service" {

  source = "git::https://git-codecommit.eu-west-1.amazonaws.com/v1/repos/terraform-aws-ecs-service?ref=0.2.0"

  name             = "MyServiceName"
  cluster          = "MyClusterName"
  task_definition  = "MyTaskDefinitionName"
  desired_count    = 2
  target_group_arn = "arn:aws:elasticloadbalancing:eu-west-1:1234567797:targetgroup/ecs-UAT/c63b4fef71808c72"

  container = {
    name = "MyContainerName"
    port = 8080
  }

  network = {
    vpc_id           = "vpc-xxxxxx"
    subnet_ids       = [ "subnet-xxxxxx", "subnet-yyyyyy" ]
    security_groups  = [ "MySecurityGroupNameX", "MySecurityGroupNameY"]
  }

}

```

### Terraform commands
* terraform init              : Initialise the module
* terraform plan              : See a plan of changes
* terraform apply             : Apply changes

### Make commands ( if a Makefile is present )
* make plan                   : Plan
* make apply                  : Apply
* make auto-apply             : Auto apply ( no prompt )

### Support 
Contact <techcloudops@sjpwealth.onmicrosoft.com>
