variable "hostname" {
  type = string
}

variable "keyname" {
  type = string
}

variable "size" {
  type = string
}

variable "security_group_ids" {
  type = list(any)
  default = []
}

variable "private_key" {
  type = string
}