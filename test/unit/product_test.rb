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

class ProductTest < ActiveSupport::TestCase
    fixtures :products

    test "product attributes must not be empty" do

        product = Product.new
        assert product.invalid?
        assert product.errors[:title].any?
        assert product.errors[:description].any?
        assert product.errors[:price].any?
        assert product.errors[:image_url].any?
    end

    test "product is not valid without a unique title" do
        product = Product.new(title:
                              products(:ruby).title,
                              description: "yyy",
                              price:
                              1,
                              image_url:
                              "fred.gif")
        assert !product.save
        assert_equal "has already been taken", product.errors[:title].join('; ')
    end
end
