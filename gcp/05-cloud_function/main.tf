resource "random_pet" "bucket-name" {
  length = 2
}

resource "random_pet" "fx-name" {
  length = 3
}

# Create a bucket to upload code
resource "google_storage_bucket" "fx-bucket" {
  location                    = "us-east1"
  name                        = random_pet.bucket-name.id
  storage_class               = "standard"
  force_destroy               = true
  uniform_bucket_level_access = true

  labels     = { "env" : "dev", "department" : "sre" }
  depends_on = [random_pet.bucket-name]
}

# Upload code to bucket
resource "google_storage_bucket_object" "src-code" {
  bucket = google_storage_bucket.fx-bucket.name
  name   = "src-1st-gen.zip"
  source = "src-1st-gen.zip"

  depends_on = [google_storage_bucket.fx-bucket]
}

# Deploy 1st gen function
resource "google_cloudfunctions_function" "fx-1st-gen" {
  name        = "fx-1st-gen"
  runtime     = "nodejs18"
  description = "My very first Terraform Cloud Function"

  available_memory_mb   = 128
  source_archive_bucket = google_storage_bucket.fx-bucket.name
  source_archive_object = google_storage_bucket_object.src-code.name
  trigger_http          = true
  entry_point           = "helloWorld"

  labels = { "env" : "dev", "department" : "sre" }
}

# Deploy 2nd gen function
resource "google_cloudfunctions2_function" "fx-2nd-gen" {
  name        = random_pet.fx-name.id
  location    = "us-east1"
  description = "My very first Cloud Function from TF"
  labels      = { "env" : "dev", "department" : "sre" }


  build_config {
    runtime     = "nodejs18"
    entry_point = "http"  # Set the entry point
    source {
      storage_source {
        bucket = google_storage_bucket.fx-bucket.name
        object = google_storage_bucket_object.src-code.name
      }
    }
  }
  service_config {
    min_instance_count = 0
    max_instance_count = 3
    available_memory   = "128Mi"
    timeout_seconds    = 60
  }
}
