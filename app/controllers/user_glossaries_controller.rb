#coding: utf-8
class UserGlossariesController < ApplicationController
  before_filter :authenticate!, :except => :show
  before_filter :valid_user?, :only => [:new, :create]

  # GET /user_glossaries/1
  def show
    @user_glossary = UserGlossary.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render :file => 'public/404.html', :status => 404, :layout => false
  end

  # GET /user_glossaries/new
  # GET /user_glossaries/new.json
  def new
    @user_glossary = UserGlossary.new

    respond_to do |format|
      format.html
      format.json { render json: @user_glossary }
    end
  end

  # POST /user_glossaries
  # POST /user_glossaries.json
  def create
    @user_glossary = current_user.user_glossaries.build(params[:user_glossary])
    @user_glossary.save!

    respond_to do |format|
      format.html { redirect_to user_glossary_path(current_user, @user_glossary), notice: 'User glossary was successfully created.' }
      format.json { render json: @user_glossary, status: :created, location: @user_glossary }
    end
  rescue => e
    respond_to do |format|
      @user_glossary.errors.add(:name, e) if @user_glossary.errors.empty?
      format.html { render action: "new" }
      format.json { render json: @user_glossary.errors, status: :unprocessable_entity }
    end
  end
end
