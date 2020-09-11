
provider "kubernetes" {
  alias  = "kubernetes"
}
variable "endpoint" {

 }

resource "kubernetes_namespace" "wordpress" {
  metadata {
    name = "wordpressns"
  }
}


resource "kubernetes_deployment" "wordpress" {
  metadata {
    name = "wordpress-deployment"
    labels = {
      test = "wordpress"
    }
    namespace=kubernetes_namespace.wordpress.metadata.0.name
    
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        test = "wordpress"
      }
    }

    template {
      metadata {
        labels = {
          test = "wordpress"
        }
      }

      spec {
        container {
          image = "wordpress:latest"
          name  = "wordpress"
          env {
            name  = "WORDPRESS_DB_HOST"
            value = "${var.endpoint.address}"
          }
          env {
            name  = "WORDPRESS_DB_USER"
            value = "${var.endpoint.username}"
          }
           env {
            name  = "WORDPRESS_DB_PASSWORD"
            value = "${var.endpoint.password}"
          }
          env {
            name  = "WORDPRESS_DB_NAME"
            value = "${var.endpoint.name}"
          }
        }
      }
    }
  }
}


resource "kubernetes_service" "wordpress-service" {
  depends_on = [kubernetes_deployment.wordpress]
  metadata {
    name = "wordpress-service"
    namespace=kubernetes_namespace.wordpress.metadata.0.name
  }
  spec {
    selector = {
      test = "${kubernetes_deployment.wordpress.metadata.0.labels.test}"
    }
    port {
      port        = 80
      target_port = 80
    }
    type = "LoadBalancer"
  }
}

resource "null_resource" "openwordpress" {
  depends_on = [kubernetes_service.wordpress-service]
  provisioner "local-exec" {
    command = "start firefox ${kubernetes_service.wordpress-service.load_balancer_ingress.0.ip}"
  }
}
