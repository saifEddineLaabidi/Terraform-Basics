variable "region" {
  default = "ca-central-1"
}
variable "cloud_users" {
     type = string
     default = "andrew:ken:faraz:mutsumi:peter:steve:braja"
  
}
variable "bucket" {
  default = "sonic-media"
  
}

variable "media" {
  type = set(string)
  default = [ 
    "/media/tails.jpg",
    "/media/eggman.jpg",
    "/media/ultrasonic.jpg",
    "/media/knuckles.jpg",
    "/media/shadow.jpg",
      ]
  
}
variable "sf" {
  type = list
  default = [
    "ryu",
    "ken",
    "akuma",
    "seth",
    "zangief",
    "poison",
    "gen",
    "oni",
    "thawk",
    "fang",
    "rashid",
    "birdie",
    "sagat",
    "bison",
    "cammy",
    "chun-li",
    "balrog",
    "cody",
    "rolento",
    "ibuki"

  ]
}

# variable "region" {
#     default = "us-east-1"
# }
# variable  "name" {
#     type = string
# }
# variable "ami" {
#     type = string
#     default = "ami-09331245601cf"
# }
# variable "small" {
#     type = string
#     default = "t2.nano"
# }
# variable "large" {
#     type = string
#     default = "t2.2xlarge"
# }