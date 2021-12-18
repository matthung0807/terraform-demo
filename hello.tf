resource "local_file" "hello" {
    filename = "${path.module}/hello.txt"
    content  = local.content
}

locals {
    name = "John"
    age = 33
    manager = true
    ext = [331, 332]
    dept = {
        name = "IT"
        employees = 5
    }

    content = <<-EOT
            Hello ${local.name}, ${local.age} years old.
            ${local.manager ? "A manager" : "An employee"} of ${local.dept.name} department with ${local.dept.employees} employees.
            Extensions are ${join(", ", local.ext)}.
            EOT
}