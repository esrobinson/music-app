module SessionsHelper

  def login!(user)
    user.reset_session_token!
    session[:session_token] = user.session_token
  end

  def logout!(user)
    session[:session_token] = nil
    user.reset_session_token!
  end

  def current_user
    @current_user ||= User.find_by_session_token(session[:session_token])
  end

  def logged_in?
    !!current_user
  end

  def admin?
    return false unless logged_in?
    current_user.admin
  end

  def require_login
    unless logged_in?
      flash[:notices] = ["You must be logged in."]
      redirect_to new_sessions_url
    end
  end

  def require_admin
    unless admin?
      flash[:notices] = ["You must be an admin to do that."]
      redirect_to bands_url
    end
  end

end