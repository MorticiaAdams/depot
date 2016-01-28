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

class OrdersController < ApplicationController
    include CurrentCart
    #load_and_authorize_resource
    #skip_before_action :authenticate_user!
    # Rails 4.x.x renamed the before-filter to before_action
    skip_before_action :authorize, only: [:new, :create]

    # GET /orders
    # GET /orders.json
    def index
        # TODO: If there are no orders for this user the program must skip the report.'
        # get the current order for this customer. There is at least one order!
        @customer = User.find_by_id(session[:user_id])
        # Searches for all previous orders and the current order (if there is one) for this customer
        @orders = Order.where(name: @customer.name).order('created_at DESC').paginate(page: params[:page], per_page: 10)

        respond_to do |format|
            format.html # index.html.erb
            format.json { render json: @orders}
        end
    end

    # GET /orders/1
    # GET /orders/1.json
    def show
        # Collect all items per order for a given customer
        @order_details= LineItem.where(order_id: set_order.id)  
    end

    # GET /orders/new
    def new
        @cart = current_cart
        if @cart.line_items.empty?
            redirect_to store_url, notice: "Your cart is empty"
            return
        end
        @order = Order.new
    end

    # GET /orders/1/edit
    def edit
    end

    # POST /orders
    # POST /orders.json
    def create
        @order = Order.new(order_params)
        @order.add_line_items_from_cart(current_cart)

        # if the user didn't enter the name, address and e-mail then the order can't be processed
        respond_to do |format|
            if @order.name.length == 0
                format.html {
                    redirect_to new_order_path, notice: 'Please enter your name'
                    return
                }
            end
            if @order.address.length == 0
                redirect_to new_order_path, notice: 'Please enter your address'
                return
            end
            if @order.email.length == 0
                redirect_to new_order_path, notice: 'Please enter your e-mail'
                return
            end
            if @order.pay_type == 0
                redirect_to new_order_path, notice: 'Please select the prefered paymend method'
                return
            end

            if @order.save
                Cart.destroy(session[:cart_id])
                #session[:cart_id] = nil
                # TODO: Add the notifier that the order will be delivered
                #          OrderNotifier.received(@order).deliver
                format.html { redirect_to store_url, notice: 'Thank you for your order.' }
                format.json { render :show, status: :created, location: @order }
            else
                format.html { render :new }
                format.json { render json: @order.errors, status: :unprocessable_entity }
            end
        end
    end

    # PATCH/PUT /orders/1
    # PATCH/PUT /orders/1.json
    def update
        @order = set_order
        respond_to do |format|
            if @order.update(order_params)
                format.html { redirect_to @order, notice: 'Order was successfully updated.' }
                format.json { render :show, status: :ok, location: @order }
            else
                format.html { render :edit }
                format.json { render json: @order.errors, status: :unprocessable_entity }
            end
        end
    end

    # DELETE /orders/1
    # DELETE /orders/1.json
    def destroy
        @order.destroy
        #set_order.destroy
        respond_to do |format|
            format.html { redirect_to orders_url, notice: 'Order was successfully destroyed.' }
            format.json { head :no_content }
        end
    end

    private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
        @order = Order.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def order_params
        params.require(:order).permit(:name, :address, :email, :pay_type)
    end
end
