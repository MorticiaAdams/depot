class SessionsController < ApplicationController
    #load_and_authorize_resource class: false
    #skip_before_action :authenticate_user!
    skip_before_action :authorize #, :access_allowed

    # Create  a new session when:
    # * The user has a valid set of logon credentials (e-mail and password)
    # * Isn't banned by an administrator
    #
    # @note When the session is created it will use the <b>user.id</b> to set the session id.
    # @note The authenticate method requires for the <b>has_secure_password</b> setting in the User model (see User).
    def create 
        # if nothing has been entered by the user there will be no object!
        user = User.find_by_name(params[:name])
        if user
            if user.authenticate(params[:password])
                session[:user_id] = user.id
                redirect_to admin_url
            else
                # if the user is nil then nothing was entered.
                redirect_to login_url, alert: "invalid user/password combination"
            end
        else
            redirect_to login_url, alert: "please log on"
        end
    end

    # Destroys the session when the user logs out.
    def destroy
        session[:user_id] = nil
        redirect_to store_url, notice: "Logged out"
    end
end
