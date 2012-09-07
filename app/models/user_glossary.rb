class UserGlossary < ActiveRecord::Base
  attr_accessible :name, :source_language, :target_language

  belongs_to :user

  #TODO: validation

  def create
    #TODO: check dupplication
    begin
      glossary_name = "%05d-%s"%[self.user_id, name]
      personal_project = LogalingServer.repository.create_personal_project(glossary_name, source_language, target_language)
    rescue Logaling::GlossaryAlreadyRegistered
      false
    end
    true
  end
end
