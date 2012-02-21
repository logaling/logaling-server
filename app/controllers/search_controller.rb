class SearchController < ApplicationController
  def index
    @query = params[:query]

    @terms = LOGALING.lookup(@query, nil)
  end
end
