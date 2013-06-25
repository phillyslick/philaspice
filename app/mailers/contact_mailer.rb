class ContactMailer < ActionMailer::Base
  
  def contact(information)
    @info = information
    mail(to: 'philadelphiaslick@gmail.com', 
         subject: "Inquiry from PhiladelphiaSpiceTrader.com",
         from: "phillyspicetrader@gmail.com")
  end
  
end
