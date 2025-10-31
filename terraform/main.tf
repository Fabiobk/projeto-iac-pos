# TERRAFORM COM DOCKER - 100% GRATUITO
terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "3.0.2"
    }
  }
}

provider "docker" {}

# Baixa imagem do NGINX
resource "docker_image" "nginx" {
  name         = "nginx:alpine"
  keep_locally = true
}

# Cria container do servidor web
resource "docker_container" "projeto_faculdade" {
  name  = "servidor-web-iac"
  image = docker_image.nginx.image_id
  
  # Porta 80 do container para 8080 do seu PC
  ports {
    internal = 80
    external = 8080
  }

  # Comando para criar página personalizada
  command = [
    "sh", 
    "-c", 
    "echo '<!DOCTYPE html><html><head><title>🎯 Projeto IaC</title><style>body{font-family:Arial;margin:40px;background:linear-gradient(135deg,#667eea,#764ba2);color:white}</style></head><body><h1>🚀 PROJETO IAC - FACULDADE</h1><div style=\"background:rgba(255,255,255,0.1);padding:20px;border-radius:10px\"><p><strong>✅ Ambiente criado com Terraform + Docker</strong></p><p><strong>Tecnologias:</strong> Terraform, Docker, NGINX</p><p><strong>Aluno:</strong> 81361173</p><p><strong>Instituição:</strong> UNYLEYA</p><p><strong>Data:</strong> $(date +\"%d/%m/%Y %H:%M\")</p></div></body></html>' > /usr/share/nginx/html/index.html && nginx -g 'daemon off;'"
  ]
}

# Mostra como acessar
output "url_do_servidor" {
  value = "🌐 Acesse: http://localhost:8080"
}

output "status_do_container" {
  value = "✅ Container Docker criado com sucesso!"
}