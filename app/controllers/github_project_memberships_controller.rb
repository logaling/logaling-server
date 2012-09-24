class GithubProjectMembershipsController < ApplicationController
  def new
    @github_project_membership = GithubProjectMembership.new
  end

  def create
    @github_project_membership = GithubProjectMembership.new(params[:github_project_membership])
    if @github_project_membership.valid?
      @github_project_membership.create_membership!
      redirect_to dashboard_path, notice: 'Membership was successfully created.'
    else
      render action: "new"
    end
  end
end
