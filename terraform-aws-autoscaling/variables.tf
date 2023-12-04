variable "region" {
  default = "ap-southeast-1"
}

variable "ami_id" {
  type = "map"
  default = {
      ap-southeast-1    = "ami-03caf91bb3d81b843"
      ap-southeast-2    = "ami-0f2967bce46537146"
      ap-south-1 = "ami-0a7cf821b91bcccbc"
  }
}

variable "key_name" {
  type    = "string"
  default = "ec2-demo"
}

variable "instance_type" {
  type    = "string"
  default = "t2.micro"
}

variable "subnets" {
  type    = list(string)
  default = ["subnet-018c5f87e900aab4f","subnet-0c3237f908ba99ec8"]
}

variable "azs" {
  type    = list(string)
  default = ["ap-southeast-1a","ap-southeast-1b"]
}

variable "security_grpup_id" {
  type    = "string"
  default = "sg-09d6229ceca2306bc"
}