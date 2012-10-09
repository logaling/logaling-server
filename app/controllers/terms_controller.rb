#coding: utf-8
class TermsController < ApplicationController
  before_filter :authenticate!
  before_filter :set_user_glossary

  def new
    @term = GlossaryEntry.new
  end

  def create
    @term = GlossaryEntry.new(params[:glossary_entry])
    @user_glossary.add!(@term)

    redirect_to user_glossary_path(current_user, @user_glossary), notice: 'Term was successfully added.'
  rescue ArgumentError, Logaling::GlossaryNotFound
    render action: "new"
  end

  def edit
    @term = GlossaryEntry.load(params[:id], @user_glossary)
  end

  def update
    @term = GlossaryEntry.load(params[:id], @user_glossary)
    new_term = GlossaryEntry.new(params[:glossary_entry])
    @user_glossary.update(@term, new_term)

    redirect_to user_glossary_path(current_user, @user_glossary), notice: 'Term was successfully updated.'
  rescue ArgumentError, Logaling::GlossaryNotFound
    render action: "edit"
  end

  def destroy
    @term = GlossaryEntry.load(params[:id], @user_glossary)
    @user_glossary.delete(@term)

    redirect_to user_glossary_path(current_user, @user_glossary), notice: 'Term was successfully destroyed.'
  rescue ArgumentError, Logaling::GlossaryNotFound
    redirect_to user_glossary_path(current_user, @user_glossary), notice: e.to_s
  end

  private
  def set_user_glossary
    @user_glossary = current_user.find_glossary(params[:glossary_id])
  rescue ActiveRecord::RecordNotFound
    render :file => 'public/404.html', :status => 404, :layout => false
  end
end
