resource "random_pet" "topic_name" {
  length = 1
}

resource "random_pet" "schema_name" {
  length = 2
}

resource "random_pet" "sub_name" {
  length = 3
}

resource "google_pubsub_schema" "schema" {
  name       = random_pet.schema_name.id
  type       = "PROTOCOL_BUFFER"
  definition = "syntax = \"proto3\";\nmessage Results {\nstring message_request = 1;\nstring message_response = 2;\nstring timestamp_request = 3;\nstring timestamp_response = 4;\n}"

}

resource "google_pubsub_topic" "topic" {
  name = random_pet.topic_name.id

  depends_on = [google_pubsub_schema.schema]
  schema_settings {
    schema   = google_pubsub_schema.schema.id
    encoding = "JSON"
  }

  labels                     = { "env" : "dev", "deployed-by" : "sre" }
  message_retention_duration = "86600s"
}

resource "google_pubsub_subscription" "subscription" {
  name  = random_pet.sub_name.id
  topic = google_pubsub_topic.topic.name

  # 20 minutes
  message_retention_duration = "1200s"
  retain_acked_messages      = true


  ack_deadline_seconds = 20
  expiration_policy {
    ttl = "300000.5s"
  }
  retry_policy {
    minimum_backoff = "10s"
  }

  enable_message_ordering = false
  labels                  = { "env" : "dev", "deployed-by" : "sre" }
}