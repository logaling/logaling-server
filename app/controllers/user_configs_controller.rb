#coding: utf-8
class UserConfigsController < ApplicationController
  before_filter :authenticate!
  before_filter :valid_user?

  def create
    current_user.create_user_config(params[:user_config])
    redirect_to dashboard_path, notice: 'User config was successfully set.'
  rescue => e
    redirect_to dashboard_path, notice: 'User config setting was failed.'
  end

  def update
    user_config = UserConfig.find(params[:id])
    if reset_of_user_config?(user_config, params[:user_config])
      user_config.destroy
    else
      user_config.update_attributes!(params[:user_config])
    end
    redirect_to dashboard_path, notice: 'User config was successfully update.'
  rescue => e
    redirect_to dashboard_path, notice: 'User config setting was failed.'
  end

  private
  def reset?(current_user_config, submitted_config_data)
    current_user_config.glossary_name == submitted_config_data[:glossary_name] &&
    current_user_config.source_language == submitted_config_data[:source_language] &&
    current_user_config.target_language == submitted_config_data[:target_language]
  end
end
