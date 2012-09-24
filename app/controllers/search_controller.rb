class SearchController < ApplicationController
  def index
    @query = params[:query]

    @terms = LogalingServer.repository.lookup(@query, glossary)
    logger.debug @terms.inspect
  end

  private
  def glossary
    user_config = signed_in? ? UserConfig.find_by_user_id(current_user.id) : nil
    if user_config
      LogalingServer.repository.find_glossary(
        user_config.glossary_name,
        user_config.source_language,
        user_config.target_language)
    else
      nil
    end
  end
end
