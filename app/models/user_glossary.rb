class UserGlossary < ActiveRecord::Base
  attr_accessible :name, :source_language, :target_language

  belongs_to :user

  validates_presence_of :name, :source_language, :target_language
  #TODO: validation

  after_create :create_personal_project!

  private
  def create_personal_project!
    LogalingServer.repository.create_personal_project(glossary_name, source_language, target_language)
  end

  def glossary_name
    "%05d-%s"%[user_id, name]
  end
end
