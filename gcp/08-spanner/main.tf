resource "random_pet" "spanner_name" {
  length = 2
}

resource "random_pet" "db_name" {
  length = 3
}

resource "google_spanner_instance" "spanner" {
  config       = "regional-us-east1"
  display_name = random_pet.spanner_name.id
  num_nodes    = 1
  labels       = { "env" : "dev", "deployed-by" : "sre" }
}

resource "google_spanner_database" "database" {
  instance = google_spanner_instance.spanner.name
  name     = random_pet.db_name.id
  deletion_protection = false
}