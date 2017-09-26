class UsersController < ApplicationController
    before_action :right_user?, only: [:show, :update, :edit, :destroy]
    def new
        @user = User.new
    end
    
    def create
      @user = User.new(user_permit_params)
      if @user.save
        @user.send_activation_token_to_email
        @user.create_image(params[:user][:image]) if params[:user][:image]
        redirect_to root_url,
        notice: "#{@user.name}, please check your email for actions"
      else
        render :new
        flash[:alert] = "Wrong_params"
      end
    end
     
    
    
    def create_from_provider
      if auth = request.env["omniauth.auth"]
        @user = User.create_omniauth_account(auth)
        @user.activated = true
        redirect_to root_url
        @user.activated_at = Time.zone.now
        log_in @user
        flash[:notice] = "Succesful signed by #{auth.provider}"
       # redirect_to @user
      else 
        redirect_to new_user_path
      end
    end
    
    def show
        #@user = User.find(params[:id])
    end
    
    def index
        @users = User.where(activated: true).order(:name)
        
    end
    
    def edit
        #@user = User.find(params[:id])
    end
    
    def update
        #@user = User.find(params[:id])
        @user.update_attributes(user_permit_params)
        flash[:success] = 'Updated attributes successfully'
        redirect_to @user
        
    end
    
    def destroy
        @user.destroy
        session[:user_id] = nil
        redirect_to root_url
    end
    
    private
    
    def user_permit_params
        params.require(:user).permit(:name, :email, :password,
        :password_confirmation)
    end
        
    def right_user?
      @user = User.find_by(id: params[:id])
      redirect_to root_url unless current_user?(@user)
    end
end
