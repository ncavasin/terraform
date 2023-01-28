resource "local_file" "string_sample" {
  filename = "${var.default_dir}/00-string_usage_sample.txt"
  content  = var.string
}

resource "local_file" "number_sample" {
  filename = "${var.default_dir}/01-number_usage_sample.txt"
  content  = var.number
}

resource "local_file" "boolean_sample" {
  filename = "${var.default_dir}/02-boolean_usage_sample.txt"
  content  = var.boolean
}

resource "local_file" "list_usage_sample" {
  filename = "${var.default_dir}/03-list_usage.txt"
  content  = "${var.list_of_string[0]} ${var.list_of_string[2]}"
}

resource "local_file" "tuple_usage_sample" {
  filename = "${var.default_dir}/04-tuple_usage_sample.txt"
  content  = "${var.tuple[0]} ${var.tuple[1]} ${var.tuple[2]}"
}

resource "local_file" "map_usage_sample" {
  filename = "${var.default_dir}/05-map_usage_sample.txt"
  content  = "${var.map["laptop_brand"]} ${var.map["laptop_model"]} ${var.map["laptop_battery_percentage"]}%"
}

resource "local_file" "runtime_defined_sample" {
  filename = "${var.default_dir}/06-runtime_defined_variable_sample.txt"
  content = var.runtime_defined_variable
}

