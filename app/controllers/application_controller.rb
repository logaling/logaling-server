#coding: utf-8
class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :current_user, :signed_in?

  private
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def signed_in?
    !!current_user
  end

  def sign_in(user)
    session[:user_id] = user.id
  end

  def sign_out
    session[:user_id] = nil
  end

  def authenticate!
    unless signed_in?
      redirect_to root_path
    else
      true
    end
  end

  def valid_user?
    if current_user.name != params[:user_id]
      redirect_to dashboard_path, notice: "不正なアクセスです"
    end
  end
end
