provider "aws" {
  region = var.aws_region
  
}

module "sns" {
  source = "./modules/sns"
  topic_name = var.sns_topic_name
  ctf_queue = module.sqs.queue_arn
}


module "sqs" {
  source = "./modules/sqs"
  
  queue_name = var.queue_name
  sns_topic_arn = module.sns.topic_arn
}
                                                                                                                                                                                                                                                                                                                                                                                                                   
