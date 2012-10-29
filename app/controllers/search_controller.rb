class SearchController < ApplicationController
  def index
    @query = params[:query] || ''
    priority_glossary = signed_in? ? current_user.priority_glossary : nil

    search_results = LogalingServer.repository.lookup(@query, priority_glossary).map do |t|
      GlossaryEntry.new do |o|
        o.extend AdditionalInformationAsSearchResults
        o.attributes = t
      end
    end
    @per_count = 10
    @terms = Kaminari.paginate_array(search_results).page(params[:page]).per(@per_count)
  end
end
