resource "local_file" "hello" {
    filename = "${path.module}/hello.txt"
    content  = var.content
}