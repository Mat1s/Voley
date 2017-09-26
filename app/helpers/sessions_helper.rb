module SessionsHelper
  
  def log_in(user)
    session[:user_id] = user.id  
  end

  def current_user
    if (user_id = cookies.signed[:user_id])
      user = User.find_by(id: user_id.to_s)
      if user && user.authenticated?(cookies.signed[:remember_token], 'remember')
        log_in(user)
        @current_user = user
      end
    elsif (user_id = session[:user_id])
       @current_user = User.find_by(id: user_id)
    end
  end

  def remember_password(user)
    user.remember
    cookies.permanent.signed[:user_id] = user.id
    cookies.permanent.signed[:remember_token] = user.remember_token
  end
  
  def forget_password(user)
    user.forget
    cookies.delete :user_id
    cookies.delete :remember_token
  end 
 
  def logged_in?
    !current_user.nil?
  end

  def current_user?(user)
    current_user == user
  end

  def log_out
    forget_password(current_user)
    session[:user_id] = nil
    @current_user = nil
  end
end
