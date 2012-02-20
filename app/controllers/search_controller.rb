class SearchController < ApplicationController
  def index
    @query = params[:query]
  end
end
