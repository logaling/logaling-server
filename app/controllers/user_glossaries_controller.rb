#coding: utf-8
class UserGlossariesController < ApplicationController
  before_filter :authenticate!, :except => :show
  before_filter :valid_user?, :except => :show

  # GET /user_glossaries/1
  def show
    @user = User.find_by_name(params[:user_id])
    @term = GlossaryEntry.new
    @terms = [GlossaryEntry.new]
    @user_glossary = @user.find_glossary(params[:id])
    @registered_terms = Kaminari.paginate_array(@user_glossary.terms).page(params[:page])
  rescue ActiveRecord::RecordNotFound
    render :file => 'public/404.html', :status => 404, :layout => false
  end

  # GET /user_glossaries/new
  def new
    @user_glossary = UserGlossary.new do |u|
      u.set_original_user_glossary_id(params[:original_user_glossary_id])
    end
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

  # DELETE /user_glossaries/1
  def destroy
    user = User.find_by_name(params[:user_id])
    @user_glossary = user.find_glossary(params[:id])
    @user_glossary.destroy
    redirect_to dashboard_path, notice: 'User glossary was successfully destroyed.'
  rescue Logaling::CommandFailed, Logaling::GlossaryNotFound => e
    redirect_to dashboard_path, notice: e.to_s
  rescue ActiveRecord::RecordNotFound
    render :file => 'public/404.html', :status => 404, :layout => false
  end
end
