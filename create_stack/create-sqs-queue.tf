resource "aws_sqs_queue" "destroyer_queue" {
  name                        = "stack-destroyer-message-queue"
}