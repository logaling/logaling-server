#coding: utf-8
class UserConfigsController < ApplicationController
  before_filter :authenticate!
  before_filter :valid_user?

  def create
    user_config = UserConfig.new(params[:user_config])
    user_config.user_id = params[:user_id]
    user_config.save!
    redirect_to dashboard_path, notice: 'User config was successfully set.'
  rescue => e
    redirect_to dashboard_path, notice: 'User config setting was failed.'
  end

  def update
    user_config = UserConfig.find(params[:id])
    if user_config.glossary_name == params[:user_config][:glossary_name] &&
      user_config.source_language == params[:user_config][:source_language] &&
      user_config.target_language == params[:user_config][:target_language]
      user_config.destroy
      redirect_to dashboard_path, notice: 'User config was successfully unset.'
    elsif user_config.update_attributes!(params[:user_config])
      redirect_to dashboard_path, notice: 'User config was successfully update.'
    end
  rescue => e
    redirect_to dashboard_path, notice: 'User config setting was failed.'
  end
end
