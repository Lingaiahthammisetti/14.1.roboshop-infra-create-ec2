variable "instances" {
  type        = map
  default     = {
    mongodb = "t3.small"
    redis = "t3.micro"
    mysql = "t3.small"
    rabbitmq = "t3.micro"
    catalogue = "t3.micro"
    user = "t3.micro"
    cart = "t3.micro"
    shipping = "t3.small"
    payment = "t3.micro"
    dispatch = "t3.micro"
    web      = "t3.micro"   
    //frontend = "t3.micro"

  }
}

variable "allow_all" {
    type = string
    default = "sg-09c7c70bd56f0d58b"
}

variable "zone_id" {
    default = "Z05177092YKCK032WQ8O6"
}

variable "domain_name" {
    default = "lingaiah.online"
}
#This is used for ansible project only
variable "ansible_master" {
  default     = {
    instance_type = "t3.small"
  }
}