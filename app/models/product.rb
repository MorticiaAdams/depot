class Product < ActiveRecord::Base
    validates :title, :description, :image_url, presence: true
    validates :price, numericality: {greater_than_or_equal_to: 0.01}
    validates :title, uniqueness: true
    # ^ and $ will flag a security warning. It is better to use fixed markers to flag the beginnen \A and the end \z
    validates :image_url, allow_blank: true, format: {
        with:
        %r{\A.(gif|jpg|png)\z}i,
        message: 'must be a URL for GIF, JPG or PNG image.'
    }
end
