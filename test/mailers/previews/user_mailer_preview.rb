class UserMailerPreview < ActionMailer::Preview
  def order_receipt
    UserMailer.order_receipt(user: User.first, order: Order.first)
  end
end