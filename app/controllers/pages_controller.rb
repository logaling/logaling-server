#coding: utf-8
class PagesController < ApplicationController
  def license; end
  def about; end

  def explore
    @github_projects = GithubProject.all
    @user_glossaries = UserGlossary.all
    @imported_projects = LogalingServer.repository.imported_projects
  end
end
