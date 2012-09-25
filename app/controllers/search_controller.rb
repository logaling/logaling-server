class SearchController < ApplicationController
  def index
    @query = params[:query]
    priority_glossary = signed_in? ? current_user.priority_glossary : nil

    @terms = LogalingServer.repository.lookup(@query, priority_glossary)
  end
end
