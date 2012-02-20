class GithubProjectsController < ApplicationController
  # GET /github_projects
  # GET /github_projects.json
  def index
    @github_projects = GithubProject.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @github_projects }
    end
  end

  # GET /github_projects/1
  # GET /github_projects/1.json
  def show
    @github_project = GithubProject.of(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @github_project }
    end
  end

  # GET /github_projects/new
  # GET /github_projects/new.json
  def new
    @github_project = GithubProject.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @github_project }
    end
  end

  # GET /github_projects/1/edit
  def edit
    @github_project = GithubProject.of(params[:id])
  end

  # POST /github_projects
  # POST /github_projects.json
  def create
    @github_project = GithubProject.new(params[:github_project])

    respond_to do |format|
      if @github_project.save
        format.html { redirect_to @github_project, notice: 'Github project was successfully created.' }
        format.json { render json: @github_project, status: :created, location: @github_project }
      else
        format.html { render action: "new" }
        format.json { render json: @github_project.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /github_projects/1
  # PUT /github_projects/1.json
  def update
    @github_project = GithubProject.of(params[:id])

    respond_to do |format|
      if @github_project.update_attributes(params[:github_project])
        format.html { redirect_to @github_project, notice: 'Github project was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @github_project.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /github_projects/1
  # DELETE /github_projects/1.json
  def destroy
    @github_project = GithubProject.of(params[:id])
    @github_project.destroy

    respond_to do |format|
      format.html { redirect_to github_projects_url }
      format.json { head :no_content }
    end
  end
end
