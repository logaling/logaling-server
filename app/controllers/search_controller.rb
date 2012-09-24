class SearchController < ApplicationController
  def index
    @query = params[:query]

    user_config = signed_in? ? UserConfig.find_by_user_id(current_user.id) : nil
    glossary = user_config ? user_config.glossary : nil
    @terms = LogalingServer.repository.lookup(@query, glossary)
  end
end
