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

class LineItemsController < ApplicationController
    include CurrentCart
    #load_and_authorize_resource
    #skip_before_action :authenticate_user!
    before_action :set_cart, only: [:create]
    before_action :set_line_item, only: [:show, :edit, :update, :destroy]
    skip_before_action :authorize, only: :create

  # GET /line_items
  # GET /line_items.json
  def index
      @line_items = LineItem.all

      respond_to do |format|
          format.html # index.html.erb
          format.json {
              render json: @line_items 
          }
      end
  end

  # GET /line_items/1
  # GET /line_items/1.json
  def show
  end

  # GET /line_items/new
  def new
    @line_item = LineItem.new
  end

  # GET /line_items/1/edit
  def edit
  end

  # POST /line_items
  # POST /line_items.json
  def create
      # Protect the application and prevent the use of an invalid product 
      begin
          # Search for the product to be linked (add) to the item line.
          product = Product.find(params[:product_id])
      rescue
          logger.error("Attempt to access an invalid product #(product_id)")
          redirect_to index("invalid product")
      else
          # Add the product. 
          @line_item = @cart.add_product(product.id)

          respond_to do |format|
              if @line_item.save
                  format.html { redirect_to  store_url}
                  format.js { @current_item = @line_item }
                  format.json { render json: @line_item, status: :created, location: @line_item }
              else
                  puts "new line item #{@cart.id} with product #{@cart.product_id}."
                  format.html { render action: "new" }
                  format.json { render json: @line_item.errors, status: :unprocessable_entity }
              end
          end
      end
  end

  # PATCH/PUT /line_items/1
  # PATCH/PUT /line_items/1.json
  def update
      respond_to do |format|
          if @line_item.update(line_item_params)
              format.html { redirect_to @line_item, notice: 'Line item was successfully updated.' }
              format.json { render :show, status: :ok, location: @line_item }
          else
              format.html { render :edit }
              format.json { render json: @line_item.errors, status: :unprocessable_entity }
          end
      end
  end

  # DELETE /line_items/1
  # DELETE /line_items/1.json
  def destroy
      @line_item.destroy
      respond_to do |format|
          format.html { redirect_to line_items_url, notice: 'Line item was successfully destroyed.' }
          format.json { head :no_content }
      end
  end
    
  private
  # Use callbacks to share common setup or constraints between actions.
  def set_line_item
      @line_item = LineItem.find_by(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def line_item_params
      params.require(:line_item).permit(:product_id, :cart_id, product_attributes: [:title])
  end
end
