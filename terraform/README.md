<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 3.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 3.75.2 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_codepipeline.CodePipelinePipeline](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/codepipeline) | resource |
| [aws_codestarconnections_connection.demo](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/codestarconnections_connection) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_CloudFormationAdminArn"></a> [CloudFormationAdminArn](#input\_CloudFormationAdminArn) | CF admin ARN required to execute the cloud formation tempalte | `string` | n/a | yes |
| <a name="input_S3BucketName"></a> [S3BucketName](#input\_S3BucketName) | S3 bucket name where the resources will be stored. | `string` | n/a | yes |
| <a name="input_branchName"></a> [branchName](#input\_branchName) | Branch name of the source code | `string` | `"main"` | no |
| <a name="input_buildProjectName"></a> [buildProjectName](#input\_buildProjectName) | CICD build project name | `string` | n/a | yes |
| <a name="input_environment"></a> [environment](#input\_environment) | Environment for the resources | `string` | `"dev"` | no |
| <a name="input_fullRepositoryId"></a> [fullRepositoryId](#input\_fullRepositoryId) | Github Respository. Example: githuborg/reponame | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->
