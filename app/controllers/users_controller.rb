# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  name            :string
#  password_digest :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  activated       :boolean          default(FALSE)
#  locked          :boolean          default(FALSE)
#  last_visit      :datetime
#  email           :string
#  salt            :string
#

class UsersController < ApplicationController
    #load_and_authorize_resource
    #before_action :authenticate_user!
    before_action :set_user, only: [:show, :edit, :update, :destroy]

    # GET /users
    # GET /users.json
    def index
        #TODO: The list of all users is is only visible for administrators
        @users = User.all.order(:name).paginate(page: params[:page], per_page: 10)
    end

    # GET /users/1
    # GET /users/1.json
    def show
    end

    # GET /users/new
    def new
        # create an empty instance user.
        @user = User.new
    end

    # GET /users/1/edit
    def edit
    end

    # POST /users
    # POST /users.json
    def create
        @user = User.new(user_params)
        respond_to do |format|
            if @user.save
                format.html { redirect_to users_url, notice: "User #{@user.name} successfully signed up." } 
                format.json { render :show, status: :created, location: @user }
            else
                format.html {
                    render :new
                }
                format.json { render json: @user.errors, status: :unprocessable_entity }
            end
        end
    end

    # PATCH/PUT /users/1
    # PATCH/PUT /users/1.json
    def update
=begin
        if user_params[:password].blank?
            user_params.delete(:password)
            user_params.delete(:password_confirmation)
        end

        successfully_updated = if needs_password?(@user, user_params)
                                   @user.update(user_params)
                               else
                                   @user.update_without_password(user_params)
                               end
=end
        respond_to do |format|
            if @user.update(user_params)
                format.html {
                    redirect_to @user,
                    notice: "User #{@user.name} was successfully updated."
                }
                format.json {
                    render :show, status: :ok,
                    location: @user
                }
            else
                format.html { render :edit }
                format.json {
                    render json: @user.errors,
                    status: :unprocessable_entity
                }
            end
        end
    end

    # DELETE /users/1
    # DELETE /users/1.json
    def destroy
        begin
            @user.destroy
            flash[:notice] = "User #{@user.name} deleted."
        rescue Exception => e
            flash[:notice] = e.message
        end

        respond_to do |format|
            format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
            format.json { head :no_content }
        end
    end

    protected
    def needs_password?(user, params)
        params[:password].present?
    end

    private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
        @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
        params.require(:user).permit(:name, :password, :password_confirmation, :password_digest, :email, :last_visit, :role_id)
    end
end
