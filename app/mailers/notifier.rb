class Notifier < ActionMailer::Base
  default :from => "onja.setex@gmail.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.notifier.order_received.subject
  #
  def order_received(order)
    @order = order
    @greeting = "Hi"

    mail :to => order.email, :subject => 'Pragmatic Store Order Confirmation' do |format|    
      format.text      
    end
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.notifier.order_shipped.subject
  #
  def order_shipped(order)
    @order = order
    @greeting = "Hi"

    mail :to => order.email, :subject => 'Pragmatic Store Order Shipped'
  end
end
