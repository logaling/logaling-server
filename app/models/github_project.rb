class GithubProject < ActiveRecord::Base
  include Project
  include GitBackended

  validates_uniqueness_of :name, :scope => :owner
  validates_format_of :owner, :name, :with => /\A[0-9a-z\-_]+\z/

  class << self
    def of(id)
      owner, name = id.split('/', 2)
      find_by_owner_and_name(owner, name)
    end
  end

  def to_param
    full_name
  end

  def full_name
    "%s/%s" % [owner, name]
  end

  def repository_path
    File.join(Rails.root, 'repositories', full_name)
  end

  def remote_repository_url
    "git://github.com/#{owner}/#{name}"
  end
end
