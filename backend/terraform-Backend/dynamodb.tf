resource "aws_dynamodb_table" "cart_table" {
  name         = "CartTable"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "userId"

  attribute {
    name = "userId"
    type = "S"
  }

  tags = {
    Name = "CartTable"
  }
}

resource "aws_dynamodb_table" "product_table" {
  name         = "ProductTable"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "productId"

  attribute {
    name = "productId"
    type = "S"
  }

  tags = {
    Name = "ProductTable"
  }
}

resource "aws_dynamodb_table" "order_table" {
  name         = "OrderTable"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "orderId"

  attribute {
    name = "orderId"
    type = "S"
  }

  tags = {
    Name = "OrderTable"
  }
}

resource "aws_dynamodb_table" "payment_table" {
  name         = "PaymentTable"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "paymentId"

  attribute {
    name = "paymentId"
    type = "S"
  }

  tags = {
    Name = "PaymentTable"
  }
}
resource "aws_dynamodb_table" "inventory_table" {
  name         = "InventoryTable"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "productId"

  attribute {
    name = "productId"
    type = "S"
  }

  tags = {
    Name = "InventoryTable"
  }
}
resource "aws_dynamodb_table" "user_table" {
  name         = "UserTable"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "userId"

  attribute {
    name = "userId"
    type = "S"
  }

  tags = {
    Name = "UserTable"
  }
}