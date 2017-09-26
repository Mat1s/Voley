class AccountActivationController < ApplicationController
  def edit
    user = User.find_by(email: params[:email])
    if user && user.authenticated?(params[:id], 'activation') && !user.activated
      if user.over_time_activated?
        flash[:alert] = 'Time for activation user is over'
        user.destroy
      else
        user.activate
        log_in(user) 
        flash[:notice] = "I'm already activated"
        redirect_to user
      end
    else
      redirect_to root_url
      flash[:alert] = "Try again"
    end
  end

  private

end