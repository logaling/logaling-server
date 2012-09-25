class Membership < ActiveRecord::Base
  belongs_to :user
  belongs_to :github_project
  accepts_nested_attributes_for :github_project

  validates_uniqueness_of :user_id, scope: :github_project_id

  scope :of, lambda {|user|
    where(user_id: user)
  }

  scope :for, lambda {|project_owner, project_name|
    joins(:github_project).merge(GithubProject.where(owner: project_owner, name: project_name))
  }
end
