class PasswordResetsController < ApplicationController
  before_action :valid_user, only: [:edit, :update]
  before_action :time_for_reset, only: [:edit, :update]
 
  def new
  end
  
  def create
    if @user = User.find_by(email: params[:email])
      @user.create_reset_password_digest
      @user.send_reset_password_digest
      flash[:info] = 'Find email with instruction'
      redirect_to "http://#{@user.email.split('@').last.to_s}"
    else
      flash.now[:alert] = 'Check your email'
      render :new
    end
  end
  
  def edit
  end
  
  def update
    if params[:email] && @user.update_attributes(reset_permit_params)
      log_in @user
      flash[:info] = "#{@user.name}'s password changed"
      redirect_to @user
    else 
      redirect_to root_url
      flash[:alert] = "Try again"
    end
  end
  
  private
  
  def reset_permit_params
    params.require(:user).permit(:password, :password_confirmation)
  end

  def valid_user
    @user = User.find_by(email: params[:email])
    unless(@user && @user.activated && @user.authenticated?(params[:id], 'reset'))
      redirect_to root_url
    end
  end

  def time_for_reset
    if @user.reset_passsword_is_over?
      redirect_to new_password_reset_path
      flash[:alert] = 'Time for reset password is over'
    else
      flash[:notice] = 'Please enter new password'
    end
  end
end
