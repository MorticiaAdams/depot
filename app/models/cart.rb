# == Schema Information
#
# Table name: carts
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

# == Cart
# 
# A placeholder this is been retefenced by all the products - <i>line items</i> - been purschased.
# ==== Attributes
# * cart_id
#
class Cart < ActiveRecord::Base
    has_many :line_items, dependent: :destroy

    # Collects line items with the same product and increments the quantity for each maching product.
    # The extra entries - row(s) - are removed from the line items table when all the items are collected and stored in a single row.
    def add_product (product_id)
        current_item = line_items.find_by_product_id(product_id)
        if current_item
            current_item.quantity += 1
        else
            # The default quantity is 1. 
            current_item = line_items.build(product_id: product_id)
        end
        current_item
    end

    # The total price for the products (line items) in the shopping cart
    def total_price
        line_items.to_a.sum { |item| item.total_price}
    end
end

