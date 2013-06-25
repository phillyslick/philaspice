class PaymentMailer < ActionMailer::Base
  def accepted_alert(order)
    @order = order
    mail(to: "philadelphiaslick@gmail.com", subject: "You've Received an Order from Philadelphiaspicetrader.com", from: "phillyspicetrader@gmail.com")
  end
  
  def customer_confirm(order)
    @order = order
    mail(to: @order.customer.email, subject: "Your Order From Philadelphia Spice Trader", from: "phillyspicetrader@gmail.com")
  end
end
