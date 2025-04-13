resource "null_resource" "Logs" {
  provisioner "local-exec" {
    command = var.Local-Exec
  }
}