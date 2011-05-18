require 'test_helper'

class NotifierTest < ActionMailer::TestCase
  test "order_received" do
    mail = Notifier.order_received(orders(:one))
    assert_equal "Pragmatic Store Order Confirmation", mail.subject
    assert_equal ["andriamasinoroonja@yahoo.fr"], mail.to
    assert_equal ["onja.setex@gmail.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

  test "order_shipped" do
    mail = Notifier.order_shipped
    aassert_equal "Pragmatic Store Order shipped", mail.subject
    assert_equal ["andriamasinoroonja@yahoo.fr"], mail.to
    assert_equal ["onja.setex@gmail.com"], mail.from
    assert_match "Hi", mail.body.encoded    
  end

end
