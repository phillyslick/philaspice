class PaymentMailer < ActionMailer::Base
  def accepted_alert(order)
    @order = order
    mail(to: "philadelphiaspicetrader@gmail.com", subject: "You've Received an Order from Philadelphiaspicetrader.com", from: "philadelphiaspicetrader@gmail.com")
  end
  
  def customer_confirm(order)
    @order = order
    mail(to: @order.customer.email, subject: "Your Order From Philadelphia Spice Trader", from: "philadelphiaspicetrader@gmail.com")
  end
end
