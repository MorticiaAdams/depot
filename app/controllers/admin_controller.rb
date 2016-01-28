class AdminController < ApplicationController
    #load_and_authorize_resource class: false
    #before_action :authenticate_user!

    def index
        #TODO: Only the admin will see the total number of orders
        # Count the number of orders for this customer.
        @customer = User.find_by_id(session[:user_id])
        @total_orders = Order.where(name: @customer.name).count
        give_time
    end
end
