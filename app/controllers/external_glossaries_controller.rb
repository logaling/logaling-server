#coding: utf-8

class ExternalGlossariesController < ApplicationController
  def show
    glossary_info = GlossaryInfo.new_by_formatted_string(params[:id])

    @project = LogalingServer.repository.find_project(glossary_info.project_name)
    @glossary = @project.glossary(glossary_info.source_language, glossary_info.target_language)

    @terms = Kaminari.paginate_array(@glossary.terms).page(params[:page])
  end
end
