class StoreController < ApplicationController
    include CurrentCart
    #load_and_authorize_resource class: false, except: [:index]
    #before_action :authenticate_user!
    before_action :current_cart
    skip_before_action :authorize

    # When a user succesfully logs an overview of all orders is presented to the user.
    def index
        if params[:set_locale]
            redirect_to store_url(locale: params[:set_locale])
        else
            @products = Product.order(:title)
            @time = Time.now.strftime("%H:%M")
            cart = :current_cart
        end
    end
end
