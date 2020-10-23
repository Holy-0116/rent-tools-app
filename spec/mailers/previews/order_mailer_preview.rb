# Preview all emails at http://localhost:3000/rails/mailers/order_mailer
class OrderMailerPreview < ActionMailer::Preview
  def send_when_order_create
   
    
    order = Order.new(lender_id: "1",borrower_id:"2")
    
    OrderMailer.send_when_order_create(order)
  end
end
