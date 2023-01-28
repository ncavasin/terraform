resource "local_file" "randomized_content_file" {
  filename = "${var.output_directory}/randomized_file.txt"
  content = "This is a line with a randomized string ${random_string.random_text.id}" # implicit dependency
}

resource "random_string" "random_text" {
  length = 20
}