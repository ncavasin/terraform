resource "random_pet" "random_bucket_names" {
  length = 2
}

resource "google_storage_bucket" "bucket" {
  name     = random_pet.random_bucket_names.id
  location = "us-east1"
  storage_class = "standard"

  depends_on = [random_pet.random_bucket_names]
}