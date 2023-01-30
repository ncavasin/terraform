resource "random_pet" "random_bucket_names" {
  length = 3
}

resource "google_storage_bucket" "bucket" {
  name                        = random_pet.random_bucket_names.id
  location                    = "us-east1"
  storage_class               = "standard"
  labels                      = { "env" = "development", "responsible" = "sre_dept" }
  # Permissions
  uniform_bucket_level_access = true
  # Lifecycle
  lifecycle_rule {
    action {
      type          = "SetStorageClass"
      storage_class = "COLDLINE"
    }
    condition {
      age = 60
    }
  }

  #  retention_policy {
  #    # Locking is an irreversible action
  #    is_locked        = true
  #    retention_period = 864000
  #  }
  depends_on = [random_pet.random_bucket_names]
}

resource "google_storage_bucket_object" "picture" {
  bucket = google_storage_bucket.bucket.name
  name   = "bokita"
  source = "bokita.jpeg"
}