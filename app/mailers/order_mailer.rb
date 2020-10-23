class OrderMailer < ApplicationMailer
  def send_when_order_create(order)
    @lender = order.lender
    @borrower = order.borrower 
    @url = "https://rent-tools-app.herokuapp.com/"
    mail  to: @lender.email,
          subject: 'レンタルの注文がありました'

  end
end
