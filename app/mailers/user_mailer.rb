class UserMailer < ApplicationMailer
  default from: 'no-reply@jungle.com'
 
  def order_receipt(params)
    @order = params[:order]
    @user  = params[:user]
    mail(to: @user.email, subject: "Your order ID is #{@order.id}")
  end
end