resource "gcp_bucket" "example" {
  name = "example"
}
resource "gcp_bucket" "example" {
  name = "example"
  labels = {
    owner : ""
    service : "foo"
  }
}
resource "gcp_bucket" "example" {
  name = "example"
  tags = {
    labels = {
      owner : "foo"
      service : ""
    }
  }
}
