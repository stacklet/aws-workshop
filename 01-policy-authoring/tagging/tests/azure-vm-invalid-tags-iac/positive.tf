resource "azure_vm" "example" {
  name = "example"
}
resource "azure_vm" "example" {
  name = "example"
  tags = {
    Owner : ""
    Service : "foo"
  }
}
resource "azure_vm" "example" {
  name = "example"
  tags = {
    labels = {
      Owner : "foo"
      Service : ""
    }
  }
}
