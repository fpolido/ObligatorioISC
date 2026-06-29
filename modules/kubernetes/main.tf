locals {
  image_base = "gcr.io/google-samples/microservices-demo"
  v          = var.app_version
}

resource "kubernetes_deployment" "redis" {
  metadata { name = "redis-cart" }
  spec {
    selector { match_labels = { app = "redis-cart" } }
    template {
      metadata { labels = { app = "redis-cart" } }
      spec {
        container {
          name  = "redis"
          image = "redis:alpine"
          port { container_port = 6379 }
          resources {
            requests = { cpu = "70m", memory = "200Mi" }
            limits   = { cpu = "125m", memory = "256Mi" }
          }
          readiness_probe {
            period_seconds = 5
            tcp_socket { port = 6379 }
          }
          liveness_probe {
            period_seconds = 5
            tcp_socket { port = 6379 }
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "redis" {
  metadata { name = "redis-cart" }
  spec {
    selector = { app = "redis-cart" }
    port {
      name        = "redis"
      port        = 6379
      target_port = 6379
    }
  }
}

resource "kubernetes_deployment" "cartservice" {
  metadata { name = "cartservice" }
  spec {
    selector { match_labels = { app = "cartservice" } }
    template {
      metadata { labels = { app = "cartservice" } }
      spec {
        termination_grace_period_seconds = 5
        container {
          name  = "server"
          image = "${local.image_base}/cartservice:${local.v}"
          port { container_port = 7070 }
          env {
            name  = "REDIS_ADDR"
            value = "redis-cart:6379"
          }
          resources {
            requests = { cpu = "200m", memory = "64Mi" }
            limits   = { cpu = "300m", memory = "128Mi" }
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "cartservice" {
  metadata { name = "cartservice" }
  spec {
    selector = { app = "cartservice" }
    port {
      name        = "grpc"
      port        = 7070
      target_port = 7070
    }
  }
}

resource "kubernetes_deployment" "productcatalogservice" {
  metadata { name = "productcatalogservice" }
  spec {
    selector { match_labels = { app = "productcatalogservice" } }
    template {
      metadata { labels = { app = "productcatalogservice" } }
      spec {
        container {
          name  = "server"
          image = "${local.image_base}/productcatalogservice:${local.v}"
          port { container_port = 3550 }
          env {
            name  = "PORT"
            value = "3550"
          }
          resources {
            requests = { cpu = "100m", memory = "64Mi" }
            limits   = { cpu = "200m", memory = "128Mi" }
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "productcatalogservice" {
  metadata { name = "productcatalogservice" }
  spec {
    selector = { app = "productcatalogservice" }
    port {
      name        = "grpc"
      port        = 3550
      target_port = 3550
    }
  }
}

resource "kubernetes_deployment" "currencyservice" {
  metadata { name = "currencyservice" }
  spec {
    selector { match_labels = { app = "currencyservice" } }
    template {
      metadata { labels = { app = "currencyservice" } }
      spec {
        container {
          name  = "server"
          image = "${local.image_base}/currencyservice:${local.v}"
          port { container_port = 7000 }
          env {
            name  = "PORT"
            value = "7000"
          }
          env {
            name  = "DISABLE_PROFILER"
            value = "1"
          }
          env {
            name  = "DISABLE_TRACING"
            value = "1"
          }
          resources {
            requests = { cpu = "100m", memory = "64Mi" }
            limits   = { cpu = "200m", memory = "128Mi" }
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "currencyservice" {
  metadata { name = "currencyservice" }
  spec {
    selector = { app = "currencyservice" }
    port {
      name        = "grpc"
      port        = 7000
      target_port = 7000
    }
  }
}

resource "kubernetes_deployment" "paymentservice" {
  metadata { name = "paymentservice" }
  spec {
    selector { match_labels = { app = "paymentservice" } }
    template {
      metadata { labels = { app = "paymentservice" } }
      spec {
        container {
          name  = "server"
          image = "${local.image_base}/paymentservice:${local.v}"
          port { container_port = 50051 }
          env {
            name  = "PORT"
            value = "50051"
          }
          env {
            name  = "DISABLE_PROFILER"
            value = "1"
          }
          env {
          name  = "DISABLE_TRACING"
          value = "1"
          }
          resources {
            requests = { cpu = "100m", memory = "64Mi" }
            limits   = { cpu = "200m", memory = "128Mi" }
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "paymentservice" {
  metadata { name = "paymentservice" }
  spec {
    selector = { app = "paymentservice" }
    port {
      name        = "grpc"
      port        = 50051
      target_port = 50051
    }
  }
}

resource "kubernetes_deployment" "shippingservice" {
  metadata { name = "shippingservice" }
  spec {
    selector { match_labels = { app = "shippingservice" } }
    template {
      metadata { labels = { app = "shippingservice" } }
      spec {
        container {
          name  = "server"
          image = "${local.image_base}/shippingservice:${local.v}"
          port { container_port = 50051 }
          env {
            name  = "PORT"
            value = "50051"
          }
          resources {
            requests = { cpu = "100m", memory = "64Mi" }
            limits   = { cpu = "200m", memory = "128Mi" }
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "shippingservice" {
  metadata { name = "shippingservice" }
  spec {
    selector = { app = "shippingservice" }
    port {
      name        = "grpc"
      port        = 50051
      target_port = 50051
    }
  }
}

resource "kubernetes_deployment" "emailservice" {
  metadata { name = "emailservice" }
  spec {
    selector { match_labels = { app = "emailservice" } }
    template {
      metadata { labels = { app = "emailservice" } }
      spec {
        container {
          name  = "server"
          image = "${local.image_base}/emailservice:${local.v}"
          port { container_port = 8080 }
          env {
            name  = "PORT"
            value = "8080"
          }
          env {
            name  = "DISABLE_TRACING"
            value = "1"
          }
          env {
            name  = "DISABLE_PROFILER"
            value = "1"
          }
          resources {
            requests = { cpu = "100m", memory = "64Mi" }
            limits   = { cpu = "200m", memory = "128Mi" }
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "emailservice" {
  metadata { name = "emailservice" }
  spec {
    selector = { app = "emailservice" }
    port {
      name        = "grpc"
      port        = 5000
      target_port = 8080
    }
  }
}

resource "kubernetes_deployment" "checkoutservice" {
  metadata { name = "checkoutservice" }
  spec {
    selector { match_labels = { app = "checkoutservice" } }
    template {
      metadata { labels = { app = "checkoutservice" } }
      spec {
        container {
          name  = "server"
          image = "${local.image_base}/checkoutservice:${local.v}"
          port { container_port = 5050 }
          env { 
            name = "PORT" 
            value = "5050" 
          }
          env { 
            name = "PRODUCT_CATALOG_SERVICE_ADDR"
            value = "productcatalogservice:3550" 
          }
          env { 
            name = "SHIPPING_SERVICE_ADDR"
            value = "shippingservice:50051" 
          }
          env { 
            name = "PAYMENT_SERVICE_ADDR"
            value = "paymentservice:50051" 
          }
          env { 
            name = "EMAIL_SERVICE_ADDR"
            value = "emailservice:5000" 
          }
          env { 
            name = "CURRENCY_SERVICE_ADDR"
            value = "currencyservice:7000" 
          }
          env { 
            name = "CART_SERVICE_ADDR"
            value = "cartservice:7070" 
          }
          resources {
            requests = { cpu = "100m", memory = "64Mi" }
            limits   = { cpu = "200m", memory = "128Mi" }
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "checkoutservice" {
  metadata { name = "checkoutservice" }
  spec {
    selector = { app = "checkoutservice" }
    port {
      name        = "grpc"
      port        = 5050
      target_port = 5050
    }
  }
}

resource "kubernetes_deployment" "recommendationservice" {
  metadata { name = "recommendationservice" }
  spec {
    selector { match_labels = { app = "recommendationservice" } }
    template {
      metadata { labels = { app = "recommendationservice" } }
      spec {
        container {
          name  = "server"
          image = "${local.image_base}/recommendationservice:${local.v}"
          port { container_port = 8080 }
          env { 
            name = "PORT"
            value = "8080" 
          }
          env { 
            name = "PRODUCT_CATALOG_SERVICE_ADDR"
            value = "productcatalogservice:3550" 
          }
          env { 
            name = "DISABLE_TRACING"
            value = "1" 
          }
          env { 
            name = "DISABLE_PROFILER"
            value = "1" 
          }
          resources {
            requests = { cpu = "100m", memory = "220Mi" }
            limits   = { cpu = "200m", memory = "450Mi" }
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "recommendationservice" {
  metadata { name = "recommendationservice" }
  spec {
    selector = { app = "recommendationservice" }
    port {
      name        = "grpc"
      port        = 8080
      target_port = 8080
    }
  }
}

resource "kubernetes_deployment" "adservice" {
  metadata { name = "adservice" }
  spec {
    selector { match_labels = { app = "adservice" } }
    template {
      metadata { labels = { app = "adservice" } }
      spec {
        container {
          name  = "server"
          image = "${local.image_base}/adservice:${local.v}"
          port { container_port = 9555 }
          env { 
            name = "PORT"
            value = "9555" 
          }
          env { 
            name = "DISABLE_STATS"
            value = "1" 
          }
          env { 
            name = "DISABLE_TRACING"
            value = "1" 
            }
          resources {
            requests = { cpu = "200m", memory = "180Mi" }
            limits   = { cpu = "300m", memory = "300Mi" }
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "adservice" {
  metadata { name = "adservice" }
  spec {
    selector = { app = "adservice" }
    port {
      name        = "grpc"
      port        = 9555
      target_port = 9555
    }
  }
}

resource "kubernetes_deployment" "frontend" {
  metadata { name = "frontend" }
  spec {
    selector { match_labels = { app = "frontend" } }
    template {
      metadata { labels = { app = "frontend" } }
      spec {
        container {
          name  = "server"
          image = "${local.image_base}/frontend:${local.v}"
          port { container_port = 8080 }
          env { 
            name = "PORT"
            value = "8080" 
          }
          env { 
            name = "PRODUCT_CATALOG_SERVICE_ADDR"
            value = "productcatalogservice:3550" 
          }
          env { 
            name = "CURRENCY_SERVICE_ADDR"
            value = "currencyservice:7000" 
          }
          env { 
            name = "CART_SERVICE_ADDR"
            value = "cartservice:7070" 
          }
          env { 
            name = "RECOMMENDATION_SERVICE_ADDR"
            value = "recommendationservice:8080" 
          }
          env { 
            name = "SHIPPING_SERVICE_ADDR"
            value = "shippingservice:50051" 
          }
          env { 
            name = "CHECKOUT_SERVICE_ADDR"
            value = "checkoutservice:5050" 
          }
          env { 
            name = "AD_SERVICE_ADDR"
            value = "adservice:9555" 
          }
          env { 
            name = "ENV_PLATFORM"
            value = "aws" 
          }
          env { 
            name = "DISABLE_TRACING"
            value = "1" 
          }
          env { 
            name = "DISABLE_PROFILER"
            value = "1" 
          }
          resources {
            requests = { cpu = "100m", memory = "64Mi" }
            limits   = { cpu = "200m", memory = "128Mi" }
          }
          readiness_probe {
            initial_delay_seconds = 10
            http_get {
              path = "/_healthz"
              port = 8080
              http_header {
                name  = "Cookie"
                value = "shop_session-id=x-readiness-probe"
              }
            }
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "frontend" {
  metadata { name = "frontend" }
  spec {
    type     = "LoadBalancer"
    selector = { app = "frontend" }
    port {
      name        = "http"
      port        = 80
      target_port = 8080
    }
  }
}