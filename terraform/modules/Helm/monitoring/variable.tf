variable "env" {
  type = string
}

variable "namespace" {
  type = string
}

variable "prometheus_repo" {
  type = string
}

variable "prometheus_chart" {
  type = string
}

# variable "slack_webhook_url" {
#  sensitive = true  
#  type = string
# }

variable "loki_repo" {
  type = string
}

variable "loki_chart" {
  type = string
}

variable "promtail_chart" {
  type = string
}