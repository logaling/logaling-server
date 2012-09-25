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

  def authenticate!
    unless signed_in?
      redirect_to root_path
    else
      true
    end
  end

  def valid_user?
    if current_user.id != params[:user_id].to_i
      redirect_to dashboard_path, notice: "不正なアクセスです"
    end
  end
end
