# Preview all emails at http://localhost:3000/rails/mailers/ordernotifier
class OrdernotifierPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/ordernotifier/received
  def received
    Ordernotifier.received
  end

  # Preview this email at http://localhost:3000/rails/mailers/ordernotifier/shipped
  def shipped
    Ordernotifier.shipped
  end

end
