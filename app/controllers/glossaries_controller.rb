class GlossariesController < ApplicationController
  def show
    @github_project = GithubProject.of(params[:github_project_id])
    source_language, target_language = params[:id].split("-")
    @glossary = @github_project.glossary(source_language, target_language)
  end
end
