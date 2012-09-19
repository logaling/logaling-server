#coding: utf-8
class TermsController < ApplicationController
  def new
    @term = Term.new
  end

  def create
    @term = Term.new(params[:term])

    @user_glossary = UserGlossary.find(params[:glossary_id])
    @user_glossary.add!(@term)

    redirect_to user_glossary_path(current_user, @user_glossary), notice: 'Term was successfully added.'
  rescue => e
    @term.errors.add(:source_term, e) if @term.errors.empty?
    render action: "new"
  end

  def edit
  end

  def update
  end

  def destroy
  end
end
