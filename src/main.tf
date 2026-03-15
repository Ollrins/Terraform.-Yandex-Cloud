resource "yandex_vpc_network" "develop" {
  name = var.vpc_name
}

resource "yandex_vpc_subnet" "develop_a" {
  name           = "${var.vpc_name}-${var.vm_res["web"].zone}"
  zone           = var.vm_res["web"].zone
  network_id     = yandex_vpc_network.develop.id
  v4_cidr_blocks = [var.subnet_web_cidr]
}

resource "yandex_vpc_subnet" "develop_b" {
  name           = "${var.vpc_name}-${var.vm_res["db"].zone}"
  zone           = var.vm_res["db"].zone
  network_id     = yandex_vpc_network.develop.id
  v4_cidr_blocks = [var.subnet_db_cidr]
}

data "yandex_compute_image" "ubuntu" {
  family = var.yandex_compute_image
}

##

resource "yandex_compute_instance" "web" {
  name        = local.web_vn
  platform_id = var.vm_res["web"].platform_id
  zone        = var.vm_res["web"].zone

  resources {
    cores         = var.vm_res["web"].cores
    memory        = var.vm_res["web"].memory
    core_fraction = var.vm_res["web"].core_fraction
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
      size     = var.vm_res["web"].disk_size
      type     = var.vm_res["web"].disk_type
    }
  }

  scheduling_policy {
    preemptible = var.vm_res["web"].preemptible
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.develop_a.id
    nat       = var.vm_res["web"].nat
  }

  metadata = local.metadata 
}

##
resource "yandex_compute_instance" "db" {
  name        = local.db_vn
  platform_id = var.vm_res["db"].platform_id
  zone        = var.vm_res["db"].zone

  resources {
    cores         = var.vm_res["db"].cores
    memory        = var.vm_res["db"].memory
    core_fraction = var.vm_res["db"].core_fraction
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
      size     = var.vm_res["db"].disk_size
      type     = var.vm_res["db"].disk_type
    }
  }

  scheduling_policy {
    preemptible = var.vm_res["db"].preemptible
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.develop_b.id
    nat       = var.vm_res["db"].nat
  }

  metadata = local.metadata
}
