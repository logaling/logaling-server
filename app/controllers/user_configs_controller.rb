#coding: utf-8
class UserConfigsController < ApplicationController
  before_filter :authenticate!
  before_filter :valid_user?

  def update
    user_config = UserConfig.find_by_user_id(params[:user_id]) || UserConfig.new
    user_config.set_config(params)
    user_config.save!
    redirect_to dashboard_path, notice: 'User config was successfully set.'
  rescue => e
    redirect_to dashboard_path, notice: 'User config setting was failed.'
  end
end
