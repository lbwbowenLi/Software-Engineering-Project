module SessionsHelper

  # Logs in the given user.
  def log_in(user)
    session[:user_id] = user.id
  end

  def remember(user)
    user.remember
    cookies.permanent.signed[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token
  end

  def forget(user)
    user.forget
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end

  # Returns the current logged-in user (if any).
  def current_user
    #debugger
    if ( session[:user_id])
      @current_user ||= User.find_by(id: session[:user_id])
    elsif (cookies.signed[:user_id])
      user = User.find_by(id: cookies.signed[:user_id])
      if user && user.authenticated?(cookies[:remember_token])
        log_in user
        @current_user = user
      end
    end
    return @current_user
  end

  # Returns true if the user is logged in, false otherwise.
  def logged_in?
    !current_user.nil?

  end

  def admin?
    current_user.admin == true
  end

  def user_name
    return current_user.name if !current_user.nil?
  end

  def log_out
    forget(current_user)
    session.delete(:user_id)
    @current_user = nil
  end
end
