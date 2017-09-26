class SessionsController < ApplicationController
    
  def new
  end

  def create
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      if user.activated
        log_in(user)
        params[:remember_password] == '1' ? remember_password(user) :
                                            forget_password(user)
        redirect_to user
      else
        flash[:alert] = "Please will activate user"
      end
    else
      flash.now[:notice] = "Enter right password or email"
      render :new
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
    flash.now[:notice] = "I closed session now"
  end
end
