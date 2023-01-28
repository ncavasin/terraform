resource "local_file" "randomized_content_file" {
  filename = "${var.output_directory}/explicit_dependency.txt"
  content = "This is a line with explicit dependency to a randomized string ${random_string.random_text.id}"
  depends_on = [random_string.random_text]
}

resource "random_string" "random_text" {
  length = 50
}