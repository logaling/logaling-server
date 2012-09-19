#coding: utf-8
class UserGlossary < ActiveRecord::Base
  attr_accessible :name, :source_language, :target_language

  belongs_to :user

  validates_presence_of :name, :source_language, :target_language
  validates_uniqueness_of :name, scope: [:user_id, :source_language, :target_language]

  after_create :create_personal_project!

  def glossary_name
    "%05d-%s" % [user_id, name]
  end

  def add!(term)
    project = LogalingServer.repository.find_project(glossary_name)
    raise Logaling::ProjectNotFound unless project
    raise Logaling::ProjectNotFound if project.class.name == 'Logaling::ImportedProject'

    raise Logaling::TermError unless term.valid?
    glossary = project.glossary(source_language, target_language)
    if glossary.bilingual_pair_exists?(term.source_term, term.target_term)
      raise Logaling::TermError, "term '#{term.source_term}: #{term.target_term}' already exists in '#{name}'"
    end

    glossary.add(term.source_term, term.target_term, term.note)
    LogalingServer.repository.index
  end

  private
  def create_personal_project!
    LogalingServer.repository.create_personal_project(glossary_name, source_language, target_language)
  end
end
