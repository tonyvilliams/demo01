terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

provider "aws" {
  region = "eu-west-2"
}

variable "environment" {
  type        = string
  default     = "dev"
  description = "Environment for the resources"
}
variable "branchName" {
  type        = string
  default     = "main"
  description = "Branch name of the source code"
}
variable "fullRepositoryId" {
  type        = string
  description = "Github Respository. Example: githuborg/reponame"
}
variable "buildProjectName" {
  type        = string
  description = "CICD build project name"
}
variable "S3BucketName" {
  type        = string
  description = "S3 bucket name where the resources will be stored. "
}
variable "CloudFormationAdminArn" {
  type        = string
  description = "CF admin ARN required to execute the cloud formation tempalte"
}
resource "aws_codestarconnections_connection" "demo" {
  name          = "demo-connection"
  provider_type = "GitHub"
}

resource "aws_codepipeline" "CodePipelinePipeline" {
  name     = "demo"
  role_arn = var.CloudFormationAdminArn
  artifact_store {
    location = var.S3BucketName
    type     = "S3"
  }
  stage {
    name = "Source"
    action {
      name     = "Source"
      category = "Source"
      owner    = "AWS"
      configuration = {
        BranchName           = "main"
        ConnectionArn        = aws_codestarconnections_connection.demo.arn
        FullRepositoryId     = var.fullRepositoryId
        OutputArtifactFormat = "CODE_ZIP"
      }
      provider = "CodeStarSourceConnection"
      version  = "1"
      output_artifacts = [
        "SourceArtifact"
      ]
      run_order = 1
    }
  }
  stage {
    name = "Build"
    action {
      name     = "Build"
      category = "Build"
      owner    = "AWS"
      configuration = {
        ProjectName = var.buildProjectName
      }
      input_artifacts = [
        "SourceArtifact"
      ]
      provider = "CodeBuild"
      version  = "1"
      output_artifacts = [
        "BuildArtifact"
      ]
      run_order = 1
    }
  }
  stage {
    name = "Create_Dev_ChangeSet"
    action {
      name     = "Create_Dev_ChangeSet"
      category = "Deploy"
      owner    = "AWS"
      configuration = {
        ActionMode            = "CHANGE_SET_REPLACE"
        Capabilities          = "CAPABILITY_NAMED_IAM"
        ChangeSetName         = "devCS"
        RoleArn               = var.CloudFormationAdminArn
        StackName             = "dev"
        TemplatePath          = "BuildArtifact::outputSamTemplate.yaml"
        TemplateConfiguration = "BuildArtifact::dev-config.json"
      }
      input_artifacts = ["BuildArtifact"]
      provider        = "CloudFormation"
      version         = "1"
      run_order       = 1
    }
  }
  stage {
    name = "execute_Dev_ChangeSet"
    action {
      name     = "deploy"
      category = "Deploy"
      owner    = "AWS"
      configuration = {
        ActionMode    = "CHANGE_SET_EXECUTE"
        ChangeSetName = "devCS"
        StackName     = "dev"
      }
      provider  = "CloudFormation"
      version   = "1"
      run_order = 1
    }
  }
  stage {
    name = "Create_Sit_ChangeSet"
    action {
      name     = "Create_Sit_ChangeSet"
      category = "Deploy"
      owner    = "AWS"
      configuration = {
        ActionMode            = "CHANGE_SET_REPLACE"
        Capabilities          = "CAPABILITY_NAMED_IAM"
        ChangeSetName         = "sitCS"
        RoleArn               = var.CloudFormationAdminArn
        StackName             = "sit"
        TemplatePath          = "BuildArtifact::outputSamTemplate.yaml"
        TemplateConfiguration = "BuildArtifact::sit-config.json"
      }
      input_artifacts = ["BuildArtifact"]
      provider        = "CloudFormation"
      version         = "1"
      run_order       = 1
    }
  }
  stage {
    name = "execute_Sit_ChangeSet"
    action {
      name     = "deploy"
      category = "Deploy"
      owner    = "AWS"
      configuration = {
        ActionMode    = "CHANGE_SET_EXECUTE"
        ChangeSetName = "sitCS"
        StackName     = "sit"
      }
      provider  = "CloudFormation"
      version   = "1"
      run_order = 1
    }
  }
  stage {
    name = "Create_Prod_ChangeSet"
    action {
      name     = "Create_ChangeSet"
      category = "Deploy"
      owner    = "AWS"
      configuration = {
        ActionMode            = "CHANGE_SET_REPLACE"
        Capabilities          = "CAPABILITY_NAMED_IAM"
        ChangeSetName         = "prodCS"
        RoleArn               = var.CloudFormationAdminArn
        StackName             = "prod"
        TemplatePath          = "BuildArtifact::outputSamTemplate.yaml"
        TemplateConfiguration = "BuildArtifact::prod-config.json"
      }
      input_artifacts = [
        "BuildArtifact"
      ]
      provider  = "CloudFormation"
      version   = "1"
      run_order = 1
    }
  }
  stage {
    name = "Execute_Prod_ChangeSet"
    action {
      name     = "deploy"
      category = "Deploy"
      owner    = "AWS"
      configuration = {
        ActionMode    = "CHANGE_SET_EXECUTE"
        ChangeSetName = "prodCS"
        StackName     = "prod"
      }
      provider  = "CloudFormation"
      version   = "1"
      run_order = 1
    }
  }
}
