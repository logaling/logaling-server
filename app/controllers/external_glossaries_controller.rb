class ExternalGlossariesController < ApplicationController
  def show
    project_name, bilingual_pair = params[:id].split('/', 2)
    source_language, target_language = bilingual_pair.split('-', 2)

    @project = LogalingServer.repository.find_project(project_name)
    @glossary = @project.glossary(source_language, target_language)

    @terms = Kaminari.paginate_array(@glossary.terms).page(params[:page])
  end
end
