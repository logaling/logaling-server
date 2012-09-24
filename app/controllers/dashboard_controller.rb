class DashboardController < ApplicationController
  before_filter :authenticate!

  def show
    @user_config = UserConfig.find_by_user_id(current_user.id) || UserConfig.new
    @user_glossaries = UserGlossary.find_all_by_user_id(current_user.id)
  end
end
