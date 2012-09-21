class UserConfig < ActiveRecord::Base
  attr_accessible :glossary, :source_language, :target_language

  belongs_to :user
end
