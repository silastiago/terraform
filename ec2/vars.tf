variable "region" {
 default = "us-east-2"
}
variable "public_key_path" {
 description = "Enter the path to the SSH Public Key to add to AWS."
 default = "certificado/solvimm.pem"
}
variable "key_name" {
 description = "Key name for SSHing into EC2"
 default = "solvimm"
}
variable "amis" {
 description = "Base AMI to launch the instances"
 default = "ami-07efac79022b86107"
 
}