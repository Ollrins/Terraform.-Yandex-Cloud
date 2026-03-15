output "vm_description" {
  description = "vm descrt"
  value = {
    web = {
      name  = yandex_compute_instance.web.name
      ip    = yandex_compute_instance.web.network_interface.0.nat_ip_address
      fqdn  = yandex_compute_instance.web.fqdn
    }
    db = {
      name  = yandex_compute_instance.db.name
      ip    = yandex_compute_instance.db.network_interface.0.nat_ip_address
      fqdn  = yandex_compute_instance.db.fqdn
    }
  }
}


output "names" {
  description = "names"
  value = {
    web_name = local.web_vn
    db_name  = local.db_vn
  }
}
