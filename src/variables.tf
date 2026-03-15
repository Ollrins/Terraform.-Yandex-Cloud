###cloud vars

variable "cloud_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/cloud/get-id"
}

variable "folder_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/folder/get-id"
}

variable "vpc_name" {
  type        = string
  default     = "develop"
  description = "VPC network & subnet name"
}

variable "vms_ssh_public_key_path" {
  type        = string
  description = "Path to public SSH key file"
  default     = "/home/Ollrins/key.pub"
}

###

variable "user" {
  type        = string
  default     = "ubuntu"
  description = "user for access"
}

variable "yandex_compute_image" {
  type        = string
  default     = "ubuntu-2004-lts"
  description = "image family"
}

variable "platform" {
  type        = string
  default     = "platform"
  description = "name?"
}

variable "env" {
  type        = string
  default     = "netology-develop"
  description = "name"
}

variable "vn_web" {
  type        = string
  default     = "web"
  description = "web"
}

variable "vn_db" {
  type        = string
  default     = "db"
  description = "db"
}


variable "vm_res" {
  type = map(object({
    cores         = number
    memory        = number
    core_fraction = number
    disk_size     = number
    disk_type     = string
    platform_id   = string
    zone          = string
    preemptible   = bool
    nat           = bool
  }))
  description = "vm resources"
  default = {
    web = {
      cores         = 2
      memory        = 2
      core_fraction = 50
      disk_size     = 10
      disk_type     = "network-hdd"
      platform_id   = "standard-v3"
      zone          = "ru-central1-a"
      preemptible   = true
      nat           = true
    }
    db = {
      cores         = 2
      memory        = 4
      core_fraction = 50
      disk_size     = 10
      disk_type     = "network-ssd"
      platform_id   = "standard-v3"
      zone          = "ru-central1-b"
      preemptible   = true
      nat           = true
    }
  }
}

### Subnet variables
variable "subnet_web_cidr" {
  type        = string
  default     = "10.0.1.0/24"
  description = "subnet a"
}

variable "subnet_db_cidr" {
  type        = string
  default     = "10.0.2.0/24"
  description = "subnet b"
}
