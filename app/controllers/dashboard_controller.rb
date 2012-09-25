class DashboardController < ApplicationController
  before_filter :authenticate!

  def show
    @user_config = current_user.user_config || UserConfig.new
    @user_glossaries = current_user.user_glossaries
  end
end
