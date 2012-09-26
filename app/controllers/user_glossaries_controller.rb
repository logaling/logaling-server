#coding: utf-8
class UserGlossariesController < ApplicationController
  before_filter :authenticate!, :except => :show
  before_filter :valid_user?, :only => [:new, :create]

  # GET /user_glossaries/1
  def show
    @term = Term.new
    @user_glossary = UserGlossary.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render :file => 'public/404.html', :status => 404, :layout => false
  end

  # GET /user_glossaries/new
  def new
    @user_glossary = UserGlossary.new
  end

  # POST /user_glossaries
  def create
    @user_glossary = current_user.user_glossaries.build(params[:user_glossary])
    @user_glossary.save!

    redirect_to user_glossary_path(current_user, @user_glossary), notice: 'User glossary was successfully created.'
  rescue => e
    @user_glossary.errors.add(:name, e) if @user_glossary.errors.empty?
    render action: "new"
  end
end
