class GithubProjectsController < ApplicationController
  # GET /github_projects/1
  # GET /github_projects/1.json
  def show
    @github_project = GithubProject.of(params[:id])

    if @github_project
      respond_to do |format|
        format.html # show.html.erb
        format.json { render json: @github_project }
      end
    else
      render :file => 'public/404.html', :status => 404, :layout => false
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
end
