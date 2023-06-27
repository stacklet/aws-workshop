resource "aws_sqs_queue" "example" {
  name = "example"
}
resource "aws_sqs_queue" "example" {
  name = "example"
  tags = {
    Contact : ""
    EUID : "foo"
    Name : "foo"
    Owner : "foo"
    Service : "foo"
  }
}
resource "aws_sqs_queue" "example" {
  name = "example"
  tags = {
    Contact : "foo"
    EUID : ""
    Name : "foo"
    Owner : "foo"
    Service : "foo"
  }
}
resource "aws_sqs_queue" "example" {
  name = "example"
  tags = {
    Contact : "foo"
    EUID : "foo"
    Name : ""
    Owner : "foo"
    Service : "foo"
  }
}
resource "aws_sqs_queue" "example" {
  name = "example"
  tags = {
    Contact : "foo"
    EUID : "foo"
    Name : "foo"
    Owner : ""
    Service : "foo"
  }
}
resource "aws_sqs_queue" "example" {
  name = "example"
  tags = {
    Contact : "foo"
    EUID : "foo"
    Name : "foo"
    Owner : "foo"
    Service : ""
  }
}
