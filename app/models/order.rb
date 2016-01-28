# == Schema Information
#
# Table name: orders
#
#  id         :integer          not null, primary key
#  name       :string
#  address    :text
#  email      :string
#  pay_type   :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Order < ActiveRecord::Base
    PAYMENT_TYPES = ["Check", "Credit card", "Purchase order"]
    belongs_to :user
    has_many :line_items, dependent: :destroy
    before_validation :normalize_credit_card_number
    validates :name, :address, :email, presence: true
    validates :pay_type, inclusion: PAYMENT_TYPES
    after_save do |order|
        logger.info "Order #{order.id} created"
    end

    # When the orrder has been payed for the virtual shopping cart
    # is emptied by removing the reference between the line item and the cart.
    def add_line_items_from_cart(cart)
        cart.line_items.each do |item|
            item.cart_id = nil
            line_items << item
        end
    end

    protected
    def normalize_credit_card_number
        # TODO: Add a credit card number entry to the form when the user selects the credit card payment type
        if PAYMENT_TYPES == 'Credit card'           
            # TODO: Allow the user to specify a credit card.
            #self.cc_number.gsub!(/[-\s]/, '')
        end
    end

    private
end
