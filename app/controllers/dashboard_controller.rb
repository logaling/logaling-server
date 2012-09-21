class DashboardController < ApplicationController
  before_filter :authenticate!

  def show
    @user_glossaries = UserGlossary.find_all_by_user_id(current_user.id)
  end
end
