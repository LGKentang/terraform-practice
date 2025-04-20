terraform {

}

variable "my_list" {
  type = list(string)
}
variable "my_map" {
  type = map(string)
}

variable "my_objects" {
  type = list(object({
    name = string
    age  = number
  }))
}

output "my_output" {
  value = var.my_map
}
