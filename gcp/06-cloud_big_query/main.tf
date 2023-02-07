resource "random_pet" "table_name" {
  length = 3
}

resource "google_bigquery_dataset" "dataset" {
  dataset_id = "dataset_from_tf"
}

resource "google_bigquery_table" "dataset_table" {
  dataset_id = "dataset_from_tf"
  table_id   = random_pet.table_name.id
}