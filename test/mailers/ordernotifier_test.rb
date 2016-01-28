require 'test_helper'

class OrdernotifierTest < ActionMailer::TestCase
  test "received" do
    mail = Ordernotifier.received(:one)
    assert_equal "Pragmatic Store Order confirmation", mail.subject
    assert_equal ["dave@nowhere.org"], mail.to
    assert_equal ["depot@nowhere.org"], mail.from
    assert_match "/1x Programming Ruby 1.9/", mail.body.encoded
  end

  test "shipped" do
    mail = Ordernotifier.shipped(order(:one))
    assert_equal "Pragmatic Store Order Shipped", mail.subject
    assert_equal ["dave@nowhere.org"], mail.to
    assert_equal ["depot@nowhere.com"], mail.from
    assert_match /<td>1&times;<\/td>\s*<td>Programming Ruby 1.9<\/td>/, mail.body.encoded
  end

end
