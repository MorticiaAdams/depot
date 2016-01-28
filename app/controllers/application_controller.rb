class ApplicationController < ActionController::Base
    # Prevent CSRF attacks by raising an exception.
    # For APIs, you may want to use :null_session instead.
    #before_action :authorize
    protect_from_forgery with: :exception
    before_action :configure_permitted_parameters, if: :devise_controller?

    rescue_from CanCan::AccessDenied do |exception|
        redirect_to store_url, :alert => exception.message
    end

    protected
    def configure_permitted_parameters
        devise_parameter_sanitizer.for(:sign_up) << :name
        devise_parameter_sanitizer.for(:account_update) << :name
    end

    #TODO: remove obsolete code block!
    # remove the method web Devise and CanCan will authorize the controllers!
    def authorize
        unless User.find_by(session[:user_id])
            respond_to login_url, notice: "PLease log in"
        end
    end

    # Gets the time for the real time clock
    # @note Required the javascript partial <b>time_portion</b>
    def give_time
        binding.pry
        @time = Time.now.strftime("%H:%M:%S ")
        render :partial => 'shared/time_portion'
    end

    private
    # Gets the current cart for <b>this</b> session.
    def current_cart
        Cart.find(session[:cart_id])
    rescue ActiveRecord::RecordNotFound
        cart = Cart.create
        session[:cart_id] = cart.id
        cart
    end
end
