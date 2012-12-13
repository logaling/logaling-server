#coding: utf-8

class ExternalGlossariesController < ApplicationController
  def show
    @glossary = ExternalGlossary.find(params[:id])
    @project = @glossary.project
    @terms = Kaminari.paginate_array(@glossary.terms).page(params[:page])
  end
end
