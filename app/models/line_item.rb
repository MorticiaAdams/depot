# == Schema Information
#
# Table name: line_items
#
#  id         :integer          not null, primary key
#  product_id :integer
#  cart_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  quantity   :integer          default(1)
#  order_id   :integer
#

class LineItem < ActiveRecord::Base
    belongs_to :order
    belongs_to :product
    belongs_to :cart
    #accepts_nested_attributes_for :product
    # Create a Hash{ Integer => product_id, quantity } from the group result to caculate the quantity for all products the have been sold.
    scope :sales, -> {
        LineItem.group(:product_id).sum(:quantity)
    }

    # Calculates the total price for the current product for <b>this</b> line item entry
    def total_price
        product.price * quantity
    end

    # Sums the quantity of all matching line items for <b>the current</b> product.
    # Returns 0 when there no line items for current product. Other it returns the sum of all quantities.
    def total_product_quantity_sold
        #Order.where('product_id == ?', LineItem.sales[0])
        sales_info = LineItem.sales.select {
            |product, quantity| product == product_id
        }
        product_quantity_sold = sales_info.map {
            |element| element[1] 
        }[0]
    end
end
