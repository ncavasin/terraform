resource "random_pet" "service-name" {
  length = 4
}

resource "google_cloud_run_service" "cloud-run-service" {
  location = "us-east1"
  name     = random_pet.service-name.id

  template {
    spec {
      containers {
        image = "us-docker.pkg.dev/cloudrun/container/hello"
        ports {
          container_port = 8080
        }
      }
    }
  }

#  traffic {
#    percent = 100
#  }
  traffic {
    revision_name = "heartily-lately-champion-cardinal-82w96"
    percent       = 50
  }
  traffic {
    revision_name = "heartily-lately-champion-cardinal-n6f5c"
    percent       = 50
  }
}

data "google_iam_policy" "public-access-policy" {
  binding {
    members = ["allUsers"]
    role    = "roles/run.invoker"
  }
}

resource "google_cloud_run_service_iam_policy" "public-access" {
  service     = google_cloud_run_service.cloud-run-service.name
  location    = google_cloud_run_service.cloud-run-service.location
  policy_data = data.google_iam_policy.public-access-policy.policy_data
}