data "aws_iam_policy_document" "ecs_assume_role" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "ecs_task_execution" {
  name               = "${var.project_name}-${var.environment}-ecs-task-execution"
  assume_role_policy = data.aws_iam_policy_document.ecs_assume_role.json

  tags = {
    Name        = "${var.project_name}-${var.environment}-ecs-task-execution"
    Project     = var.project_name
    Environment = var.environment
    ManagedBy   = "terraform"
  }
}

resource "aws_iam_role_policy_attachment" "ecs_task_execution" {
  role       = aws_iam_role.ecs_task_execution.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

resource "aws_iam_role" "ecs_task" {
  name               = "${var.project_name}-${var.environment}-ecs-task"
  assume_role_policy = data.aws_iam_policy_document.ecs_assume_role.json

  tags = {
    Name        = "${var.project_name}-${var.environment}-ecs-task"
    Project     = var.project_name
    Environment = var.environment
    ManagedBy   = "terraform"
  }
}

resource "aws_iam_role_policy_attachment" "task_additional" {
  for_each = toset(var.additional_policy_arns)

  role       = aws_iam_role.ecs_task.name
  policy_arn = each.value
}

# GitHub OIDC allows GitHub Actions to acquire AWS credentials without storing long-lived secrets.
data "tls_certificate" "github_actions" {
  count = var.enable_github_oidc && var.github_repository != "" ? 1 : 0
  url   = "https://token.actions.githubusercontent.com"
}

resource "aws_iam_openid_connect_provider" "github" {
  count = var.enable_github_oidc && var.github_repository != "" ? 1 : 0

  url = "https://token.actions.githubusercontent.com"

  client_id_list = [
    "sts.amazonaws.com",
  ]

  thumbprint_list = [
    data.tls_certificate.github_actions[0].certificates[0].sha1_fingerprint,
  ]
}

data "aws_iam_policy_document" "github_actions_assume_role" {
  count = var.enable_github_oidc && var.github_repository != "" ? 1 : 0

  statement {
    actions = ["sts:AssumeRoleWithWebIdentity"]

    principals {
      type        = "Federated"
      identifiers = [aws_iam_openid_connect_provider.github[0].arn]
    }

    condition {
      test     = "StringEquals"
      variable = "token.actions.githubusercontent.com:aud"
      values   = ["sts.amazonaws.com"]
    }

    condition {
      test     = "StringLike"
      variable = "token.actions.githubusercontent.com:sub"
      values = var.github_environment != "" ? [
        "repo:${var.github_repository}:environment:${var.github_environment}",
        ] : [
        "repo:${var.github_repository}:ref:refs/heads/${var.github_branch}",
      ]
    }
  }
}

resource "aws_iam_role" "github_actions_deploy" {
  count = var.enable_github_oidc && var.github_repository != "" ? 1 : 0

  name               = "${var.project_name}-${var.environment}-github-oidc"
  assume_role_policy = data.aws_iam_policy_document.github_actions_assume_role[0].json

  tags = {
    Name        = "${var.project_name}-${var.environment}-github-oidc"
    Project     = var.project_name
    Environment = var.environment
    ManagedBy   = "terraform"
  }
}

resource "aws_iam_role_policy_attachment" "github_actions_deploy" {
  for_each = var.enable_github_oidc && var.github_repository != "" ? toset(var.oidc_role_policy_arns) : toset([])

  role       = aws_iam_role.github_actions_deploy[0].name
  policy_arn = each.value
}
