class SearchController < ApplicationController
  def index
    @query = params[:query]
    priority_glossary = signed_in? ? current_user.priority_glossary : nil

    @terms = LogalingServer.repository.lookup(@query, priority_glossary).map do |t|
      Term.new do |o|
        o.extend AdditionalInformationAsSearchResults
        o.attributes = t
      end
    end
  end
end
