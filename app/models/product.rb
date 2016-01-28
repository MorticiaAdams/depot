# == Schema Information
#
# Table name: products
#
#  id          :integer          not null, primary key
#  title       :string
#  description :text
#  image_url   :string
#  price       :decimal(8, 2)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_products_on_title  (title) UNIQUE
#

class Product < ActiveRecord::Base
    validates :title, :description, :image_url, presence: true
    validates :price, numericality: {greater_than_or_equal_to: 0.01}
    validates :title, uniqueness: true
    # ^ and $ will flag a security warning. It is better to use fixed markers to flag the beginnen \A and the end \z
=begin FIXME: this validation fails to validate a correct file extension.
    validates :image_url, allow_blank: true,
    format: {
        with: /\A.(gif|jpg|png)\z/, message: 'must be a URL for GIF, JPG or PNG image.'
    }
=end
    validates :price,
        presence: true,
        numericality: true,
        format: {
            with: /\A\d{1,4}(\.\d{0,2})?\z/
        }
    has_many :line_items
    has_many :orders, through: :line_items
    before_destroy :ensure_not_referenced_by_any_line_item
    
    # Calculatie the total for an order by summing quantity id off all line_items with a specific product id.
    def quantity_sold
        if LineItem.find_by_product_id(id)
            LineItem.find_by_product_id(id).total_product_quantity_sold
        else
            0
        end
    end

    private
    def ensure_not_referenced_by_any_line_item
        if line_items.empty?
            return true
        else
            errors.add(:base, 'Line Items are present.')
            return false
        end
    end
end
