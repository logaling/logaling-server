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
    raise Logaling::TermError unless term.valid?

    glossary = LogalingServer.repository.find_glossary(glossary_name, source_language, target_language)
    raise Logaling::GlossaryNotFound unless glossary

    if glossary.bilingual_pair_exists?(term.source_term, term.target_term)
      raise Logaling::TermError, "term '#{term.source_term}: #{term.target_term}' already exists in '#{name}'"
    end

    glossary.add(term.source_term, term.target_term, term.note)
    LogalingServer.repository.index
  end

  def update(term, new_term)
    raise Logaling::TermError unless term.valid?

    glossary = LogalingServer.repository.find_glossary(glossary_name, source_language, target_language)
    raise Logaling::GlossaryNotFound unless glossary

    unless glossary.bilingual_pair_exists?(term.source_term, term.target_term)
      raise Logaling::TermError, "term '#{term.source_term}: #{term.target_term}' doesn't exist in '#{name}'"
    end

    glossary.update(term.source_term, term.target_term, new_term.target_term, new_term.note)
    LogalingServer.repository.index
  end

  def delete(term)
    raise Logaling::TermError unless term.valid?

    glossary = LogalingServer.repository.find_glossary(glossary_name, source_language, target_language)
    raise Logaling::GlossaryNotFound unless glossary

    unless glossary.bilingual_pair_exists?(term.source_term, term.target_term)
      raise Logaling::TermError, "term '#{term.source_term}: #{term.target_term}' doesn't exist in '#{name}'"
    end

    glossary.delete(term.source_term, term.target_term)
    LogalingServer.repository.index
  end

  def terms(annotation=nil)
    glossary = LogalingServer.repository.find_glossary(glossary_name, source_language, target_language)
    raise Logaling::GlossaryNotFound unless glossary
    terms = glossary.terms(annotation).map { |term_hash| Term.set_value(term_hash) }
  end

  private
  def create_personal_project!
    LogalingServer.repository.create_personal_project(glossary_name, source_language, target_language)
  end
end
