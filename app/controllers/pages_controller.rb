#coding: utf-8
class PagesController < ApplicationController
  def license; end
  def about; end

  def explore
    @github_projects = GithubProject.all
    @user_glossaries = UserGlossary.all
    @imported_projects = imported_projects
  end

  private
  #TODO: Logaling::Repository#imported_projects を用意して、そちらを使う
  def imported_projects
    LogalingServer.repository.projects.select {|project| project.is_a? Logaling::ImportedProject }
  end
end
