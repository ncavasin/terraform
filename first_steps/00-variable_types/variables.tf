variable "default_dir" {
  type = string
  default = "output_files"
}
variable "filename" {
  type = string
  default = "00-regular_var_usage.txt"
}

variable "number" {
  type = number
  default = 17
}

variable "boolean" {
  type = bool
  default = false
}

variable "string" {
  type = string
  default = "this is a string"
}

variable "list_of_string" {
  type = list(string)
  default = ["Hi", "this", "is", "a", "list"]
}

variable "tuple" {
  type = tuple([string, bool, number])
  default = ["Hi", true, 17]
}

variable "map" {
  type = map
  default = {laptop_brand = "Lenovo", laptop_model = "Thinkbook", laptop_battery_percentage = 72 }
}

########################################################################################################################

# If I uncommment the line below, TF will ask for a value whenever 'TF apply" is executed
variable "runtime_defined_variable" {
  type = string
}