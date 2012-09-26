#coding: utf-8
class UserGlossary < ActiveRecord::Base
  attr_accessible :name, :source_language, :target_language

  belongs_to :user

  validates_presence_of :name, :source_language, :target_language
  validates_uniqueness_of :name, scope: [:user_id, :source_language, :target_language]

  after_create :create_personal_project!

  class << self
    def find_by_term(term_hash, user)
      conditions = {}
      user_id, conditions[:name] = term_hash[:glossary_name].split("-", 2)
      return nil if user.id != user_id.to_i
      conditions[:source_language] = term_hash[:source_language]
      conditions[:target_language] = term_hash[:target_language]
      conditions[:user_id] = user.id
      UserGlossary.find(:first, :conditions => conditions)
    end
  end

  def glossary_name
    "%05d-%s" % [user_id, name]
  end

  def add!(term)
    raise ArgumentError unless term.valid?

    glossary = find_glossary
    raise Logaling::GlossaryNotFound unless glossary

    glossary.add(term.source_term, term.target_term, term.note)
    LogalingServer.repository.index

  rescue Logaling::TermError
    term.errors.add(:source_term, "term '#{term.source_term}: #{term.target_term}' already exists in '#{name}'")
    raise ArgumentError
  end

  def update(term, new_term)
    return if term == new_term
    raise ArgumentError unless new_term.valid?

    glossary = find_glossary
    raise Logaling::GlossaryNotFound unless glossary

    glossary.update(term.source_term, term.target_term, new_term.target_term, new_term.note)
    LogalingServer.repository.index

  rescue Logaling::TermError
    term.errors.add(:target_term, "term '#{term.source_term}: #{new_term.target_term}' already exists in '#{name}'")
    raise ArgumentError
  end

  def delete(term)
    raise ArgumentError unless term.valid?

    glossary = find_glossary
    raise Logaling::GlossaryNotFound unless glossary

    glossary.delete(term.source_term, term.target_term)
    LogalingServer.repository.index

  rescue Logaling::TermError
    term.errors.add(:target_term, "term '#{term.source_term}: #{term.target_term}' doesn't exists in '#{name}'")
    raise ArgumentError
  end

  def find_bilingual_pair(soruce_term, target_term)
    glossary = find_glossary
    raise Logaling::GlossaryNotFound unless glossary

    glossary.find_bilingual_pairs(soruce_term, target_term).first
  end

  def terms(annotation=nil)
    glossary = find_glossary
    raise Logaling::GlossaryNotFound unless glossary
    terms = glossary.terms(annotation).map { |term_attrs| Term.new(term_attrs) }
  end

  private
  def find_glossary
    LogalingServer.repository.find_glossary(glossary_name, source_language, target_language)
  end

  def create_personal_project!
    LogalingServer.repository.create_personal_project(glossary_name, source_language, target_language)
  end
end
