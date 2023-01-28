output "input_filename" {
  value = data.local_file.input_filename.content
  depends_on = [data.local_file.input_filename]
}