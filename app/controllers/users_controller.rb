#coding: utf-8
class UsersController < ApplicationController
  def new
    @user = User.new(session[:user_info])
  end

  def create
    @user = User.new(params[:user]) do |u|
      u.provider = session[:user_info][:provider]
      u.uid = session[:user_info][:uid]
    end

    if @user.save
      sign_in(user)
      session[:user_info] = nil
      redirect_to dashboard_url
    else
      render :new
    end
  end
end
