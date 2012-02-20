class TopController < ApplicationController
  def index
    @projects = GithubProject.all
  end
end
