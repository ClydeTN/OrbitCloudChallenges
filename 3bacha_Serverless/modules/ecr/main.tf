resource "aws_ecrpublic_repository" "lambda_repo" {
  repository_name = "souassi-lambda-repo"
}

# Render Dockerfile from template
data "template_file" "dockerfile" {
  template = file("${path.module}/Dockerfile.tpl")
  vars = {
    flag_api_url = var.flag_api_url
    api_key      = var.api_key
  }
}

resource "local_file" "dockerfile" {
  content  = data.template_file.dockerfile.rendered
  filename = "${path.module}/Dockerfile"
}

resource "null_resource" "docker_build_push" {
  depends_on = [local_file.dockerfile, aws_ecrpublic_repository.lambda_repo]

  provisioner "local-exec" {
    command = <<EOT
      docker build -t ${aws_ecrpublic_repository.lambda_repo.repository_uri}:latest ${path.module}
      aws ecr-public get-login-password --region ${var.region} | docker login --username AWS --password-stdin public.ecr.aws
      docker push ${aws_ecrpublic_repository.lambda_repo.repository_uri}:latest
    EOT
  }
}

output "image_uri" {
  value = "${aws_ecrpublic_repository.lambda_repo.repository_uri}:latest"
}

output "ecr_repo_url" {
  value = aws_ecrpublic_repository.lambda_repo.repository_uri
} 