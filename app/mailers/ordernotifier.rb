class Ordernotifier < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.ordernotifier.received.subject
  #
  def received(order)
    @order = order

    mail to: order.email, subject:'"Pragmatic Store Order confirmation'
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.ordernotifier.shipped.subject
  #
  def shipped(order)
    @order = order 

    mail to: order.email, subject: 'Pragmatic Store Order Shipped'
  end
end
