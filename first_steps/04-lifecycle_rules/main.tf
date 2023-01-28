resource "random_integer" "random_int" {
  max = 121
  min = 0
  lifecycle {
    create_before_destroy = true
  }
}

resource "random_pet" "random_pet_name" {
  length = 200
  # This lifecycle rule only allows initial appliance and ignores further updates to the resource.
  lifecycle {
    ignore_changes = [length]
  }
}

# Uncomment below resource to test lifecycle rule
#resource "random_string" "random_text" {
#  length = 100
#  # This lifecycle rule avoids deletion when resources is updated after initial appliance.
#  lifecycle {
#    prevent_destroy = true
#  }
#}