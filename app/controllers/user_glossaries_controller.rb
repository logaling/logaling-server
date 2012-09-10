#coding: utf-8
class UserGlossariesController < ApplicationController
  before_filter :authenticate!, :except => :show
  before_filter :valid_user?, :only => [:new, :create]

  # GET /user_glossaries/1
  # GET /user_glossaries/1.json
  def show
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
    if @user_glossary.create
      respond_to do |format|
        if @user_glossary.save
          format.html { render action: "show", notice: 'User glossary was successfully created.' }
          format.json { render json: @user_glossary, status: :created, location: @user_glossary }
        else
          format.html { render action: "new" }
          format.json { render json: @user_glossary.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  private
  def valid_user?
    if current_user.id != params[:user_id].to_i
      redirect_to dashboard_path, notice: "不正なアクセスです"
    end
  end
end
