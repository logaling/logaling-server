class GithubProject < ActiveRecord::Base
  def full_name
    "%s/%s" % [owner, name]
  end
end
