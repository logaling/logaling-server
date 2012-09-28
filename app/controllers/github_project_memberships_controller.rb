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

  def destroy
    membership = Membership.find(params[:id])
    membership.destroy
    redirect_to dashboard_path, notice: 'Github project membership was successfully destroyed.'
  rescue ActiveRecord::RecordNotFound
    render :file => 'public/404.html', :status => 404, :layout => false
  end
end
