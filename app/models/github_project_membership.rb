#coding: utf-8
class GithubProjectMembership
  include ActiveAttr::Model

  attribute :project_owner, type: String, default: ''
  attribute :project_name, type: String, default: ''
  attribute :user_id, type: Integer

  validates_presence_of :project_owner, :project_name, :user_id
  validate :user_must_not_belongs_to_github_project_yet, if: Proc.new {|data|
    data.github_project.present?
  }

  def create_membership!
    GithubProject.transaction do
      unless github_project.present?
        GithubProject.create!(owner: project_owner, name: project_name)
      end
      github_project.users << user
    end
  end

  def github_project
    @github_project ||= GithubProject.of(full_name)
  end

  def user
    @user ||= User.where(id: user_id).first
  end

  private
  def full_name
    "%s/%s" % [project_owner, project_name]
  end

  def user_must_not_belongs_to_github_project_yet
    unless Membership.where(user_id: user_id).joins(:github_project).merge(GithubProject.where(owner: project_owner, name: project_name)).empty?
      errors.add :project_name, "は既に登録されています"
    end
  end
end
