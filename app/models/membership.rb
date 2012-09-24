class Membership < ActiveRecord::Base
  belongs_to :user
  belongs_to :github_project
  accepts_nested_attributes_for :github_project

  validates_uniqueness_of :user_id, scope: :github_project_id
end
