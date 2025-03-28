resource "aws_secretsmanager_secret" "app-encryption" {
  name = "app-encription"
}

resource "aws_secretsmanager_secret" "db-secrets" {
  name = "db-secrets"
}

resource "aws_secretsmanager_secret" "argocd-git-repo-key" {
  name = "argocd-git-repo-key"
}

/** **/

resource  "aws_secretsmanager_secret_version" "app-encryption" {
  secret_id     = aws_secretsmanager_secret.app-encryption.id
  secret_string = jsonencode(var.app-encryption)
}

resource  "aws_secretsmanager_secret_version" "db-secrets" {
  secret_id     = aws_secretsmanager_secret.db-secrets.id
  secret_string = jsonencode(var.db-secrets)
}

resource  "aws_secretsmanager_secret_version" "argocd-git-repo-key" {
  secret_id     = aws_secretsmanager_secret.argocd-git-repo-key.id
  secret_string = jsonencode(var.argocd-git-repo-key)
}

/** **/

variable  "app-encryption" {
  sensitive = true
}

variable "db-secrets" {
  sensitive = true
}

variable "argocd-git-repo-key" {
  sensitive = true
}
