module Coolbelt::Controller::UrlAuth
  extend ActiveSupport::Concern

  included do
    before_action do
      if params[:x]
        user = GlobalID::Locator.locate_signed(params[:x], for: "login")
        self.current_user = user
        session[:source] = params[:source] if params[:source].present?
        url = params[:redirect_path].presence || url_for(only_path: true)

        redirect_to url
      end
    end

    helper_method :current_user
    helper_method :impersonating?
    helper_method :logged_in?

    before_action do
      if impersonating? && current_user.nil?
        logout
      end
    end
  end

  def impersonating?
    session[:admin_user_id].present?
  end

  def current_user
    if session[:user_id]
      Current.user ||= User.find_by(id: session[:user_id])
    end
  end

  def current_user=(user)
    session[:user_id] = user&.id
    Current.user = user
  end

  def authenticate!
    redirect_to(:login) unless current_user
  end

  def logged_in?
    !!current_user
  end

  def impersonate_user(user)
    if current_user&.admin?
      session[:admin_user_id] = session[:user_id]
    end
    self.current_user = user
  end

  def logout
    if session[:admin_user_id]
      session[:user_id] = session.delete(:admin_user_id)
    else
      session.delete(:user_id)
    end
    Current.user = nil
  end

  def pwa?
    session[:source] == "pwa"
  end
end
