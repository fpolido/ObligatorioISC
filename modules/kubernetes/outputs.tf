output "frontend_url" {
  description = "URL pública del frontend"
  value       = "http://${kubernetes_service.frontend.status[0].load_balancer[0].ingress[0].hostname}"
}