resource "gcp_bucket" "example" {
  name = "example"
  labels = {
    owner : "foo"
    service : "foo"
  }
}
