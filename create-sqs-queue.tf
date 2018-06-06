resource "aws_sqs_queue" "terraform_queue" {
  name                        = "stack-destroyer-message-queue"
  //fifo_queue                  = true
  //content_based_deduplication = true
}