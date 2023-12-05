variable "region" {
  type    = "string"
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
variable "instance_type" {
  type    = "string"
  default = "t2.micro"
}
variable "key_name" {
  type    = "string"
  default = "ec2-demo"
}