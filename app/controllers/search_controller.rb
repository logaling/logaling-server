class SearchController < ApplicationController
  def index
    @query = params[:query]

    @terms = LogalingServer.repository.lookup(@query, nil)
  end
end
