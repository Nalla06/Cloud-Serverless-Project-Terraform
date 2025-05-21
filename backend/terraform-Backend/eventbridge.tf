# Custom EventBridge Bus
resource "aws_cloudwatch_event_bus" "ecommerce_bus" {
  name = "ecommerce-event-bus"
}

# Rule: Checkout Order Event
resource "aws_cloudwatch_event_rule" "checkout_order_rule" {
  name        = "CheckoutOrderRule"
  event_bus_name = aws_cloudwatch_event_bus.ecommerce_bus.name
  event_pattern = jsonencode({
    "source": ["com.simpleshopmicroservices.checkout"],
    "detail-type": ["Checkout Order"]
  })
}

resource "aws_cloudwatch_event_target" "checkout_order_target" {
  rule      = aws_cloudwatch_event_rule.checkout_order_rule.name
  arn       = aws_lambda_function.checkout_handler.arn
  event_bus_name = aws_cloudwatch_event_bus.ecommerce_bus.name
}

# Rule: Update Order Status Event
resource "aws_cloudwatch_event_rule" "update_status_rule" {
  name        = "UpdateStatusRule"
  event_bus_name = aws_cloudwatch_event_bus.ecommerce_bus.name
  event_pattern = jsonencode({
    "source": ["com.simpleshopmicroservices.order"],
    "detail-type": ["Update Order Status"]
  })
}

resource "aws_cloudwatch_event_target" "update_status_target" {
  rule      = aws_cloudwatch_event_rule.update_status_rule.name
  arn       = aws_lambda_function.order_handler.arn
  event_bus_name = aws_cloudwatch_event_bus.ecommerce_bus.name
}

# Rule: Delete All Cart Items
resource "aws_cloudwatch_event_rule" "delete_cart_rule" {
  name        = "DeleteCartRule"
  event_bus_name = aws_cloudwatch_event_bus.ecommerce_bus.name
  event_pattern = jsonencode({
    "source": ["com.simpleshopmicroservices.cart"],
    "detail-type": ["Delete All Cart Item"]
  })
}

resource "aws_cloudwatch_event_target" "delete_cart_target" {
  rule      = aws_cloudwatch_event_rule.delete_cart_rule.name
  arn       = aws_lambda_function.cart_handler.arn
  event_bus_name = aws_cloudwatch_event_bus.ecommerce_bus.name
}
