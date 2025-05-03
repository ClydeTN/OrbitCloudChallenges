output "image_uri" {
  value = "${aws_ecrpublic_repository.lambda_repo.repository_uri}:latest"
}

output "ecr_repo_url" {
  value = aws_ecrpublic_repository.lambda_repo.repository_uri
} 