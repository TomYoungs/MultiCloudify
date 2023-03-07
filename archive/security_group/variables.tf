variable "name" {
  type        = string
  description = "The name of the security group."
}

variable "description" {
  type        = string
  description = "The description of the security group."
}

variable "ssh_from_port" {
  type        = number
  description = "The starting port number for SSH traffic."
  default     = 22
}

variable "ssh_to_port" {
  type        = number
  description = "The ending port number for SSH traffic."
  default     = 22
}

variable "ssh_protocol" {
  type        = string
  description = "The protocol to use for SSH traffic."
  default     = "tcp"
}

variable "ssh_cidr_blocks" {
  type        = list(string)
  description = "The CIDR blocks to allow SSH traffic from."
  default     = ["0.0.0.0/0"]
}

variable "http_from_port" {
  type        = number
  description = "The starting port number for HTTP traffic."
  default     = 80
}

variable "http_to_port" {
  type        = number
  description = "The ending port number for HTTP traffic."
  default     = 80
}

variable "http_protocol" {
  type        = string
  description = "The protocol to use for HTTP traffic."
  default     = "tcp"
}

variable "http_cidr_blocks" {
  type        = list(string)
  description = "The CIDR blocks to allow HTTP traffic from."
  default     = ["0.0.0.0/0"]
}

variable "egress_from_port" {
  type        = number
  description = "The starting port number for egress traffic."
  default     = 0
}

variable "egress_to_port" {
  type        = number
  description = "The ending port number for egress traffic."
  default     = 0
}

variable "egress_protocol" {
  type        = string
  description = "The protocol to use for egress traffic."
  default     = "-1"
}

variable "egress_cidr_blocks" {
  type        = list(string)
  description = "The CIDR blocks to allow egress traffic to."
  default     = ["0.0.0.0/0"]
}
