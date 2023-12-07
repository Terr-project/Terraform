provider "aws" {
  region = var.region
}

resource "aws_clodwatch_event_rule" "default" {
    count = var.enabled ==true ? 1 : 0

  name = var.cloudwatch_event_rule_name
  description = var.description
  event_pattern = <<EOF
  {
    "detail-type":[
        "AWS Console Sign In via CloudTrail"
    ]
  }
  EOF
     role_arn = var.role_arn
     is_enabled = var.is_enabled
}

resource "aws_cloudwatch_event_target" "default" {
  count = var.enabled == true ? 1 : 0 
  rule = aws_cloudwatch_event_rule.default.*.name[0]
  target_id = var.target_id
  arn = aws_sns_topic.this[count.index].arn
  input_path = var.input_path != "" ? var.input_path : null
  role_arn = var.target_role_arn
}

resource "aws_sns-topic" "this" {
  count = var.enabled ? 1 : 0

  name = var.sns_name
  display_name = var.sns_display_name
  kms_master_key_id = var.kms_master_key_id
  delivery_policy = var.delivery_policy
  fifo_topic = var.fifo_topic
  content_based_deduplication = var.content_based_deduplication
}

resource "aws_sns_topic_subscription" "this" {
  for_each = var.enabled ? var.subscibers : {}

  topic_arn  = join("", aws_sns_topic.thus.*.arn)
  protocol = var.subscibers[each.key].protocol
  endpoint = aws_lamda_function.terraform_lambda_func.arn
  endpoint_auto_confirms = var.subscibers[each.key].endpoint_auto_confirms
  raw_message_delivery = var.subscibers[each.key].raw_message_delivery
}

resource "aws_sns_topic_policy" "default" {
  count = var.sns_topic_policy_enabled ? 1 : 0

  arn = aws_sns_topic.this[count.index].arn
  policy = data.aws_iam_policy_document.sns_topic_policy[count.index].json  
}

data "aws_iam_policy_document" "sns_topic_Policy" {
  count = var.sns_topic_policy_enabled ? 1 : 0
  statement {
    effect = "Allow"
    actions = ["SNA:Publish"]

    principals {
      type = "service"
      identifiers = ["events.amazonaws.com"]
    }

    resources = [aws_sns_topic.this[count.index].arn]
  }
}

resource "aws_iam_role" "lambda_role" {
  name = "S3cloud_Test_Lambda_Function_Role"
  assume_role_policy = <<EOF
}