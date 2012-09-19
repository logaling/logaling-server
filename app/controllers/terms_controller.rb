#coding: utf-8
class TermsController < ApplicationController
  def new
    @term = Term.new

    respond_to do |format|
      format.html
      format.json { render json: @term }
    end
  end

  def create
    @term = Term.new(params[:term])
    @user_glossary = UserGlossary.find(params[:glossary_id])
    @user_glossary.add!(@term)

    respond_to do |format|
      format.html { redirect_to user_glossary_path(current_user, @user_glossary), notice: 'Term was successfully added.' }
      format.json { render json: @user_glossary, status: :created, location: @user_glossary }
    end
  rescue => e
    respond_to do |format|
      @term.errors.add(:source_term, e) if @term.errors.empty?
      format.html { render action: "new" }
      format.json { render json: @term.errors, status: :unprocessable_entity }
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end
end
