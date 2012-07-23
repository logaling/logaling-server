class GithubProject < ActiveRecord::Base
  include Project
  include GitBackended

  validates_uniqueness_of :name, :scope => :owner
  validates_format_of :owner, :name, :with => /\A[0-9a-z\-_]+\z/

  after_create :sync!

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
    File.join(LogalingServer.repository_base, full_name)
  end

  def remote_repository_url
    "git://github.com/#{owner}/#{name}"
  end

  # project name for logaling
  def logaling_name
    "github-%s-%s" % [owner, name]
  end

  def glossaries
    registered_project.glossaries
  end

  def glossary(source_language, target_language)
    registered_project.glossary(source_language, target_language)
  end

  private
  def registered_project
    LogalingServer.repository.find_project(logaling_name)
  end
end
